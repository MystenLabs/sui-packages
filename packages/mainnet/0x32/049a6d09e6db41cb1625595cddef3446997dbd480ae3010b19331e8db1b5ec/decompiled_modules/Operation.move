module 0x32049a6d09e6db41cb1625595cddef3446997dbd480ae3010b19331e8db1b5ec::Operation {
    struct SUIRC20Action has store, key {
        id: 0x2::object::UID,
        inscription: 0x1::string::String,
    }

    struct OPERATION has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SUIRC20Action{
            id          : 0x2::object::new(arg2),
            inscription : arg0,
        };
        0x2::transfer::transfer<SUIRC20Action>(v0, arg1);
    }

    fun init(arg0: OPERATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"inscription"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{inscription}"));
        let v2 = 0x2::package::claim<OPERATION>(arg0, arg1);
        let v3 = 0x2::display::new_with_fields<SUIRC20Action>(&v2, v0, v1, arg1);
        0x2::display::update_version<SUIRC20Action>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SUIRC20Action>>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun op(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SUIRC20Action{
            id          : 0x2::object::new(arg1),
            inscription : arg0,
        };
        0x2::transfer::share_object<SUIRC20Action>(v0);
    }

    // decompiled from Move bytecode v6
}

