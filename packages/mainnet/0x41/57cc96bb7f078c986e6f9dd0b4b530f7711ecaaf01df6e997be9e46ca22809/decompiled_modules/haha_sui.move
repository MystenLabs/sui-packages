module 0x4157cc96bb7f078c986e6f9dd0b4b530f7711ecaaf01df6e997be9e46ca22809::haha_sui {
    struct HAHA_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA_SUI>(arg0, 6, b"HAHA", b"haha coin", b"The most valuable coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blush-tremendous-canidae-396.mypinata.cloud/ipfs/QmSNRiCLDCZ2RJFvn9mJ7gmWpm45pgNAZeJJ3wYEkaje5F")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHA_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HAHA_SUI>>(0x2::coin::mint<HAHA_SUI>(&mut v2, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAHA_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

