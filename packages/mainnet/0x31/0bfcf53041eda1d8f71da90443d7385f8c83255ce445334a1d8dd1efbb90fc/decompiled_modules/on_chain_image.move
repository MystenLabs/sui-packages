module 0x310bfcf53041eda1d8f71da90443d7385f8c83255ce445334a1d8dd1efbb90fc::on_chain_image {
    struct Image has store, key {
        id: 0x2::object::UID,
        data: vector<u8>,
        mime_type: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct ImageUploaded has copy, drop {
        id: address,
        uploader: address,
    }

    public fun upload_image(arg0: vector<u8>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Image {
        let v0 = Image{
            id          : 0x2::object::new(arg3),
            data        : arg0,
            mime_type   : arg1,
            description : arg2,
        };
        let v1 = ImageUploaded{
            id       : 0x2::object::id_address<Image>(&v0),
            uploader : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ImageUploaded>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

