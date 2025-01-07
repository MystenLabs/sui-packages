module 0xa627eaf20dd327a84aff1eff1960e18720225925c07d46a3f02448bbf0f663c9::suishy {
    struct SUISHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHY>(arg0, 9, b"SUISHY", b"Sui Fish Suishy", b"Let me introduce to you Sui Fish Suishy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/076/636/929/large/marie-henry-fish-handpaint-01.jpg?1717440726")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISHY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

