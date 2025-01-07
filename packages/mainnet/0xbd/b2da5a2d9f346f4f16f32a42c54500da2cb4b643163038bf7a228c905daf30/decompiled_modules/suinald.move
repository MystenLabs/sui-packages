module 0xbdb2da5a2d9f346f4f16f32a42c54500da2cb4b643163038bf7a228c905daf30::suinald {
    struct SUINALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINALD>(arg0, 6, b"SUINALD", b"DONALD on SUI", b"SUINALD is Making SUI Great Again!  By the people, for the people! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k9tnjbxo_400x400_1a25b72030.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

