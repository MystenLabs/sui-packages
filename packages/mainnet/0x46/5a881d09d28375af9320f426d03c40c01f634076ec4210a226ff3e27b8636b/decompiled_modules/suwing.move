module 0x465a881d09d28375af9320f426d03c40c01f634076ec4210a226ff3e27b8636b::suwing {
    struct SUWING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWING>(arg0, 6, b"SUWING", b"Suwing Chain", b"The official Swing token on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_01_at_00_58_39_9914cb14ec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWING>>(v1);
    }

    // decompiled from Move bytecode v6
}

