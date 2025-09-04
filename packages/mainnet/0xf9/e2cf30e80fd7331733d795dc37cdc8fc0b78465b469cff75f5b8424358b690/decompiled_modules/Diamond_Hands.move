module 0xf9e2cf30e80fd7331733d795dc37cdc8fc0b78465b469cff75f5b8424358b690::Diamond_Hands {
    struct DIAMOND_HANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMOND_HANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMOND_HANDS>(arg0, 9, b"DHS", b"Diamond Hands", b"diamonds hands are forever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz7FtHgWgAABZOO?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAMOND_HANDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMOND_HANDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

