To map shared data folder into your instances, open a terminal window and paste the following code: 

```
curl https://jetstream2.exosphere.app/exosphere/assets/scripts/mount_ceph.py | sudo python3 - mount \
  --access-rule-name="MorphoCloudCephShare-ro" \
  --access-rule-key="AQAIDi1nKwbRFRAA9KKHUddANj6Ywj8ag7N9pg==" \
  --share-path="149.165.158.38:6789,149.165.158.22:6789,149.165.158.54:6789,149.165.158.70:6789,149.165.158.86:6789:/volumes/_nogroup/60bf684c-51d1-4abb-93f5-188d4d164111/1fe273cd-1e4d-4087-ad2b-01d548a16fe0" \
  --share-name="MorphoCloudCephShare"

```
This is a one-time setup, unless the instance has to be deleted and re-created. Share will be mapped to:

**/media/share/MorphoCloudCephShare**

and it will be read-only. You should continue saving your data into the your **MyData** folder (located in /media/volumes/MyData)
