module 0xb3fff903ece93e765766a564d04b276964545755cc9874265bb6f7021422c16::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<TEST>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::coin::deny_list_contains<TEST>(arg0, v1)) {
                0x2::coin::deny_list_add<TEST>(arg0, arg1, v1, arg3);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TEST>(arg0, 6, b"TEST", b"Test Coin", b"Test Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.pinimg.com/736x/48/64/20/486420f8cbba9ee760de26f50a1ea7b2.jpg"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v3, 100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

