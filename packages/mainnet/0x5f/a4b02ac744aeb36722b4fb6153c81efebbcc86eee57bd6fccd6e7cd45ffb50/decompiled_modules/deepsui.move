module 0x5fa4b02ac744aeb36722b4fb6153c81efebbcc86eee57bd6fccd6e7cd45ffb50::deepsui {
    struct DEEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPSUI>(arg0, 6, b"DEEPSUI", b"DeepSUIseek", b"No socials. MADE IN CHINA. I'm here to dethrone the American AI. 100M is the goal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055013_7ea7814094.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

