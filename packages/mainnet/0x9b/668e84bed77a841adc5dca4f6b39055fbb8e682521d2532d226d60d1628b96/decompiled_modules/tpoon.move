module 0x9b668e84bed77a841adc5dca4f6b39055fbb8e682521d2532d226d60d1628b96::tpoon {
    struct TPOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPOON>(arg0, 6, b"TPOON", b"To The Poon", b"To The Moon Poon | https://suimoonthepoon.fun https://x.com/MoonthePool_Sui https://t.me/PoolOnSui_Portal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_03_35_48_ec8d98e907.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TPOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

