module 0x662eccf1e6399ea99f1f93fc8d0fbc368000bb5455f22981ac52cfff6db86112::foxyy {
    struct FOXYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXYY>(arg0, 9, b"FOXYY", b"FOXYY", b"FOXY SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0xf28147869eb343b0786093ecb6afa6999f4a0d94.png?size=xl&key=c59305")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOXYY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXYY>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOXYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

