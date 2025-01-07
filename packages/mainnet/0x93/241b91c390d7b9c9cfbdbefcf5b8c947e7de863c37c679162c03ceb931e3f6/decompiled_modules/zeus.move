module 0x93241b91c390d7b9c9cfbdbefcf5b8c947e7de863c37c679162c03ceb931e3f6::zeus {
    struct ZEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEUS>(arg0, 6, b"Zeus", b"SuiZeus", x"4b696e67206f662074686520676f6473200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047197_5ee24234d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

