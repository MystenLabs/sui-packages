module 0x44eb9716279a538ccc2240e55a0f36ab92efcffa698a95d97ca548176a004dcc::deepnft {
    struct DEEPBOOKNFT has store, key {
        id: 0x2::object::UID,
    }

    struct DEEPNFT has drop {
        dummy_field: bool,
    }

    public entry fun free_mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        mint(arg0, arg1);
    }

    fun init(arg0: DEEPNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Deepbook Airdrop Live"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://deepbook.live/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://i.imgur.com/06JNlkW.jpeg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Deepbook DEEP Token Airdrop, holders of DEEP Token NFT will be able to convert it to DEEP tokens."));
        let v4 = 0x2::package::claim<DEEPNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DEEPBOOKNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<DEEPBOOKNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DEEPBOOKNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DEEPBOOKNFT{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DEEPBOOKNFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

