module 0xe2323ce60f2a42ecf284ef1cb8b61b47e7b122aca3e2d6a01ee216ff919626d4::frig {
    struct FRIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIG>(arg0, 6, b"FRIG", b"FRIGGY", b"Leap into the Future with Friggy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_27_at_18_32_04_f0c9ca90c4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

