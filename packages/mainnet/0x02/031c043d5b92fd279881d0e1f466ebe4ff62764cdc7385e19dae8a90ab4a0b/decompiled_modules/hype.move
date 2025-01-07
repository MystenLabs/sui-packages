module 0x2031c043d5b92fd279881d0e1f466ebe4ff62764cdc7385e19dae8a90ab4a0b::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 6, b"Hype", b"Hype Tracker", b"unlock the Edge in Crypto with Hype Tracker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_14_27_20_e75a2ec0ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

