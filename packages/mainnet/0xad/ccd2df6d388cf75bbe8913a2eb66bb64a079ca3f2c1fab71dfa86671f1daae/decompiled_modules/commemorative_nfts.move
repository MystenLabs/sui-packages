module 0xadccd2df6d388cf75bbe8913a2eb66bb64a079ca3f2c1fab71dfa86671f1daae::commemorative_nfts {
    struct COMMEMORATIVE_NFTS has drop {
        dummy_field: bool,
    }

    struct Commemorative has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: COMMEMORATIVE_NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COMMEMORATIVE_NFTS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Sui Basecamp Paris 2024"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://storage.googleapis.com/basecamp-images/Commemorative-NFT.gif"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A commemorative NFT for the 1st annual Sui Basecamp in Paris, France."));
        let v5 = 0x2::display::new_with_fields<Commemorative>(&v0, v1, v3, arg1);
        0x2::display::update_version<Commemorative>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Commemorative>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint_commemorative(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : Commemorative {
        Commemorative{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

