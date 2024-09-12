### Instance Creation Progress {{ .status }}

|    Create IP     |    Create Volume     |    Create Instance     |    Associate IP     |    Setup Instance     |    Attach volume     |    Send Email     |
| :--------------: | :------------------: | :--------------------: | :-----------------: | :-------------------: | :------------------: | :---------------: |
| {{ .create_ip }} | {{ .create_volume }} | {{ .create_instance }} | {{ .associate_ip }} | {{ .setup_instance }} | {{ .attach_volume }} | {{ .send_email }} |

See details at {{ .details_url }}
