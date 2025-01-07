module 0xc790ac97f52e68d21ada8d950981ec7e9b2d7e0ed5c25acacfcec01490a56088::serv {
    struct SERV has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SERV>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SERV>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SERV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x40e3d1a4b2c47d9aa61261f5606136ef73e28042.png?size=lg&key=d9b10e                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<SERV>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SERV    ")))), trim_right(b"OpenServ                        "), trim_right(b"OpenServ has developed an end-to-end solution enabling agents across domains, frameworks, and specialties to work together seamlessly in a unified environmentcombining custom cognitive frameworks, collaborative architectures, and intelligent integrations to enable novel ways of executing work                           "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SERV>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SERV>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<SERV>>(0x2::coin::mint<SERV>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SERV>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

