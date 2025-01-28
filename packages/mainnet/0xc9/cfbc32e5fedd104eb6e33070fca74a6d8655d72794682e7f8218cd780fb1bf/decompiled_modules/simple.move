module 0xc9cfbc32e5fedd104eb6e33070fca74a6d8655d72794682e7f8218cd780fb1bf::simple {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        let v0 = 0;
        while (v0 < arg3) {
            v0 = v0 + 1;
            let v1 = NFT{
                id          : 0x2::object::new(arg4),
                name        : arg0,
                description : arg1,
                url         : 0x2::url::new_unsafe_from_bytes(arg2),
            };
            0x2::transfer::public_transfer<NFT>(v1, 0x2::tx_context::sender(arg4));
        };
    }

    // decompiled from Move bytecode v6
}

