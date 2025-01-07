module 0x94756461b95986de7954fd76633fb765121091461ddb24cf8d4f64e7c98100c8::puixel {
    struct PUIXEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUIXEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUIXEL>(arg0, 6, b"PUIXEL", b"Puixel Aqua", b"The Simplest Water On Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_05_at_11_51_06_AM_b2b4e8c71a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUIXEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUIXEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

