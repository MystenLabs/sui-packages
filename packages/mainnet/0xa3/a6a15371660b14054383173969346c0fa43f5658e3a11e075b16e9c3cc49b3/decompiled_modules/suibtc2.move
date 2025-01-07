module 0xa3a6a15371660b14054383173969346c0fa43f5658e3a11e075b16e9c3cc49b3::suibtc2 {
    struct SUIBTC2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBTC2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBTC2>(arg0, 6, b"SUIBTC2", b"BITCOIN 2.0", b"Official BTC 2.0 on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3508_2899e40922.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBTC2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBTC2>>(v1);
    }

    // decompiled from Move bytecode v6
}

