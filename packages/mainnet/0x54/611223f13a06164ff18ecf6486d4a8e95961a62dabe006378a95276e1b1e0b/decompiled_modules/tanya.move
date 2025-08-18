module 0x54611223f13a06164ff18ecf6486d4a8e95961a62dabe006378a95276e1b1e0b::tanya {
    struct TANYA has drop {
        dummy_field: bool,
    }

    struct Tanya has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: TANYA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Tanya{
            id        : 0x2::object::new(arg1),
            name      : 0x1::string::utf8(x"e382bfe383bce3838be383a3"),
            image_url : 0x1::string::utf8(b"https://interestprotocol.infura-ipfs.io/ipfs/QmUKfHTKYjecNbUy7HdGtfri8vq3u16VLsUkziJHicxHDc"),
        };
        let v1 = 0x2::package::claim<TANYA>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        let v6 = 0x2::display::new_with_fields<Tanya>(&v1, v2, v4, arg1);
        0x2::display::update_version<Tanya>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, @0xed7ba9119e330d5032637eb573a4078e6c80c2ae17e3c77382a90fc2fe640f92);
        0x2::transfer::public_transfer<0x2::display::Display<Tanya>>(v6, @0xed7ba9119e330d5032637eb573a4078e6c80c2ae17e3c77382a90fc2fe640f92);
        0x2::transfer::public_transfer<Tanya>(v0, @0xed7ba9119e330d5032637eb573a4078e6c80c2ae17e3c77382a90fc2fe640f92);
    }

    // decompiled from Move bytecode v6
}

