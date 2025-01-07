module 0x594bc3bb4d96a9691d4b161f77671c8a93ef740b70872bb2ac6db7cc6268a1cf::nft {
    struct Owner has key {
        id: 0x2::object::UID,
    }

    struct Item has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Owner{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Owner>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &Owner, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        0x2::transfer::transfer<Item>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

