### Instance Creation Progress {{ .status }}

|    Create IP     |    Create Volume     |    Create Instance     |    Associate IP     |    Setup Instance     |    Attach volume     |    Retrieve Connection URL    |    Send Email     |
| :--------------: | :------------------: | :--------------------: | :-----------------: | :-------------------: | :------------------: | :---------------------------: | :---------------: |
| {{ .create_ip }} | {{ .create_volume }} | {{ .create_instance }} | {{ .associate_ip }} | {{ .setup_instance }} | {{ .attach_volume }} | {{ .retrieve_connection_url}} | {{ .send_email }} |

See details at {{ .details_url }}
