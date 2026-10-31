module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_damages {
    struct ItemDamages has copy, drop, store {
        from: u16,
        to: u16,
        damage_type: 0x1::string::String,
        element: 0x1::string::String,
    }

    public fun damage_type(arg0: &ItemDamages) : 0x1::string::String {
        arg0.damage_type
    }

    public fun element(arg0: &ItemDamages) : 0x1::string::String {
        arg0.element
    }

    public fun from(arg0: &ItemDamages) : u16 {
        arg0.from
    }

    public fun is_element(arg0: &0x1::string::String) : bool {
        if (*arg0 == 0x1::string::utf8(b"earth")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"fire")) {
            true
        } else if (*arg0 == 0x1::string::utf8(b"water")) {
            true
        } else {
            *arg0 == 0x1::string::utf8(b"air")
        }
    }

    public fun new(arg0: u16, arg1: u16, arg2: 0x1::string::String, arg3: 0x1::string::String) : ItemDamages {
        assert!(arg0 <= arg1, 901);
        assert!(is_element(&arg3), 902);
        ItemDamages{
            from        : arg0,
            to          : arg1,
            damage_type : arg2,
            element     : arg3,
        }
    }

    public fun to(arg0: &ItemDamages) : u16 {
        arg0.to
    }

    // decompiled from Move bytecode v7
}

