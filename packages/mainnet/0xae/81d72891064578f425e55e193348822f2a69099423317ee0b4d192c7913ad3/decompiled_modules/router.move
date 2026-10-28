module 0xae81d72891064578f425e55e193348822f2a69099423317ee0b4d192c7913ad3::router {
    struct Witness has drop {
        dummy_field: bool,
    }

    public(friend) fun bound(arg0: u128, arg1: u128, arg2: bool) : u128 {
        if (arg2) {
            assert!(arg0 < arg1, 100);
            0x1::u128::max(arg0, 4295048016 + 1)
        } else {
            assert!(arg0 > arg1, 100);
            0x1::u128::min(arg0, 79226673515401279992447579055 - 1)
        }
    }

    public(friend) fun witness() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

