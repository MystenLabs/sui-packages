module 0xb9830052aa1ac80262a6216796312e1011b90194c01f45480e0cad3b53ca6323::deepsui {
    struct DEEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPSUI>(arg0, 6, b"DEEPSUI", b"Deepsuieek", b"No socials. MADE IN CHINA. I'm here to dethrone the American AI. 100M is the goal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055013_82f870c16c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

