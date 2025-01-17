module 0x15a0974f933480eb0443746f73e1bc9f2ab6bc522d327780b56d13aa91e2c1a2::belle {
    struct BELLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELLE>(arg0, 6, b"BELLE", b"Belle AI", b"first #NSFW onlyfans model on Sui. Automated by Ai, sexy and useful, with a subscription to burn model.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_ezgif_com_webp_to_jpg_converter_6b413670a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

