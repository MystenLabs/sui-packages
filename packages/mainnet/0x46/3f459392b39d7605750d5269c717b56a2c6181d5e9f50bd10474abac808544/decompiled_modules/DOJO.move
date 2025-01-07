module 0x463f459392b39d7605750d5269c717b56a2c6181d5e9f50bd10474abac808544::DOJO {
    struct DOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOJO>(arg0, 9, b"DOJO", b"DojoSwap", b"DojoSwap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1736317809582608384/ZDO1dxxb_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOJO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOJO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOJO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOJO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

