module 0x7c72dd2a57f09d24071e0adfe2cb60f404b82a75702cfd0e274ed1e867cb6d6::ythosi {
    struct YTHOSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YTHOSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YTHOSI>(arg0, 6, b"YTHOSI", b"YTHOSI YOKAMOTO SUI", b"Sell 1 Million Bitcoin For Buy Ythosi!! -Ythosi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_09_at_09_58_21_a852b02116.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YTHOSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YTHOSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

