module 0x9dfe3c8654f8d1f18d7b98eee3aa2d023f198ce22177ef42e4d6ec08738a9ba3::aaapepe {
    struct AAAPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPEPE>(arg0, 6, b"AAAPEPE", b"AAAPEPEONSUI", b"Make pepe great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/464e0f47ba2bbaa873d963536df3a38_4d36491707.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

