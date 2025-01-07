module 0xcb2c2f281371340e8eea98063d6415fadde863ccacb65fd529f9fd598c885046::chookie {
    struct CHOOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOOKIE>(arg0, 6, b"CHOOKIE", b"Chookie", b"Chookie On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chookie_b8fc5af9b7.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

