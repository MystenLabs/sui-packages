module 0x316933ef9b27c341cfbb4f66f1943b1c1d75d25f571e617b521fb47fb647e53e::collar_ntf {
    struct COLLAR_NTF has drop {
        dummy_field: bool,
    }

    struct COLLARNTF has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: COLLAR_NTF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/49566393"));
        let v4 = 0x2::package::claim<COLLAR_NTF>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<COLLARNTF>(&v4, v0, v2, arg1);
        0x2::display::update_version<COLLARNTF>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<COLLARNTF>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_and_transfer(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = COLLARNTF{
            id   : 0x2::object::new(arg2),
            name : arg0,
        };
        0x2::transfer::public_transfer<COLLARNTF>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

