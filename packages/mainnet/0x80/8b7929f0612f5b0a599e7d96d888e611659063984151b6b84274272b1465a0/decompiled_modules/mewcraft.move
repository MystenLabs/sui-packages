module 0x808b7929f0612f5b0a599e7d96d888e611659063984151b6b84274272b1465a0::mewcraft {
    struct MEWCRAFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWCRAFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWCRAFT>(arg0, 6, b"MEWCRAFT", b"cat in a minecraft world", b"A Cat In A Minecraft World $MEWCRAFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241215_162401_698_677c4b235b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWCRAFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEWCRAFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

