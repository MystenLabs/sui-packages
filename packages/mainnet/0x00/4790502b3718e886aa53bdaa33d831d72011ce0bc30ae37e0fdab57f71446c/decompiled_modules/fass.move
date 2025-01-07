module 0x4790502b3718e886aa53bdaa33d831d72011ce0bc30ae37e0fdab57f71446c::fass {
    struct FASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FASS>(arg0, 6, b"Fass", b"fass", b"fass token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_08_27_at_8_53_34a_PM_1a0f080ed9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

