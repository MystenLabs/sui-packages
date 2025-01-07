module 0x63614efd2454e72a93cbba663dc465908cdf023b165123b89af771e21b6ea5a9::muiga {
    struct MUIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUIGA>(arg0, 6, b"MUIGA", b"Muigaman", b"Megaman's new adventure is on chain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_06_at_10_17_26_PM_42194e4001.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

