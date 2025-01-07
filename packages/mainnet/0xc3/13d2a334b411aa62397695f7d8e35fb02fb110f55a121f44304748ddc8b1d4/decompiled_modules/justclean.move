module 0xc313d2a334b411aa62397695f7d8e35fb02fb110f55a121f44304748ddc8b1d4::justclean {
    struct JUSTCLEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTCLEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTCLEAN>(arg0, 6, b"JUstclean", b"Justclean", b"justclean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_36833a7a56.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTCLEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUSTCLEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

