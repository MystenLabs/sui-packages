module 0xcc41d2ed1bfe5c73914b4919b363df84fcd2ccc2870b8d90754d388d3921875d::image {
    struct Image has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        description: vector<u8>,
        data: vector<u8>,
    }

    public fun get_image_metadata(arg0: &Image) : (vector<u8>, vector<u8>, vector<u8>) {
        (arg0.name, arg0.description, arg0.data)
    }

    public fun inscribe_image(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Image{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            data        : arg2,
        };
        0x2::transfer::public_transfer<Image>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

