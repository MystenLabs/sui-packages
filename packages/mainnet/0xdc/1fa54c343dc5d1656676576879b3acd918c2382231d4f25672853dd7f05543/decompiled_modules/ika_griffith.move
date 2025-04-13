module 0xdc1fa54c343dc5d1656676576879b3acd918c2382231d4f25672853dd7f05543::ika_griffith {
    struct IKA_GRIFFITH has drop {
        dummy_field: bool,
    }

    struct IkaGriffith has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: IKA_GRIFFITH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<IKA_GRIFFITH>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<IkaGriffith>(&v4, v0, v2, arg1);
        0x2::display::update_version<IkaGriffith>(&mut v5);
        let v6 = new_nft(arg1);
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<IkaGriffith>(v6, v7);
        0x2::transfer::public_transfer<0x2::display::Display<IkaGriffith>>(v5, v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v7);
    }

    fun new_nft(arg0: &mut 0x2::tx_context::TxContext) : IkaGriffith {
        IkaGriffith{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(x"e382b0e383aae38395e382a3e382b9"),
            image_url : 0x1::string::utf8(b"https://interestprotocol.infura-ipfs.io/ipfs/QmTKiN6RR7Jd1yKwkPmKMdNpJSc1dQSZd7XNCiGP2bn317"),
        }
    }

    // decompiled from Move bytecode v6
}

