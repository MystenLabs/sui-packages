module 0xb66438bad70d9fa0ddb5a42d0f3cddc7cfb74ad003d11c4be8df32a29d79feea::ghnft {
    struct GHNFT has drop {
        dummy_field: bool,
    }

    struct MYGHNFT has store, key {
        id: 0x2::object::UID,
        gh_id: 0x1::string::String,
        image: 0x1::string::String,
    }

    fun init(arg0: GHNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"gh_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{gh_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image}"));
        let v4 = 0x2::package::claim<GHNFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MYGHNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MYGHNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MYGHNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MYGHNFT{
            id    : 0x2::object::new(arg1),
            gh_id : 0x1::string::utf8(b"chongmingdu"),
            image : 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/22591706"),
        };
        0x2::transfer::public_transfer<MYGHNFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

