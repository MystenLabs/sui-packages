module 0xf529a1436c7876149f7848b9640ebabc875e5c257c07acf2127139aacde77d2c::kingofthesea {
    struct KINGOFTHESEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGOFTHESEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGOFTHESEA>(arg0, 6, b"KINGOFTHESEA", b"King of the Sea", b"Ruling the waves, $KINGOFTHESEA commands the deep waters of the Sui Network. Fearless and dominant, hes ready to conquer every ocean. Bow to the king!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_7c4c2c93d5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGOFTHESEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGOFTHESEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

