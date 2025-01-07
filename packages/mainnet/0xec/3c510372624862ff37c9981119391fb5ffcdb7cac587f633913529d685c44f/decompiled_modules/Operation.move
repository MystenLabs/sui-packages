module 0xec3c510372624862ff37c9981119391fb5ffcdb7cac587f633913529d685c44f::Operation {
    struct Operation has store, key {
        id: 0x2::object::UID,
        data: 0x1::string::String,
    }

    struct OPERATION has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Operation{
            id   : 0x2::object::new(arg2),
            data : arg0,
        };
        0x2::transfer::transfer<Operation>(v0, arg1);
    }

    fun init(arg0: OPERATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"data"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{data}"));
        let v2 = 0x2::package::claim<OPERATION>(arg0, arg1);
        let v3 = 0x2::display::new_with_fields<Operation>(&v2, v0, v1, arg1);
        0x2::display::update_version<Operation>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Operation>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun op(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Operation{
            id   : 0x2::object::new(arg1),
            data : arg0,
        };
        0x2::transfer::share_object<Operation>(v0);
    }

    // decompiled from Move bytecode v6
}

