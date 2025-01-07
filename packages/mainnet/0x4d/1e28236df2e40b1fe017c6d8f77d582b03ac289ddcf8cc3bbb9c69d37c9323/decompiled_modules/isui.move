module 0x4d1e28236df2e40b1fe017c6d8f77d582b03ac289ddcf8cc3bbb9c69d37c9323::isui {
    struct ISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISUI>(arg0, 6, b"iSUI", b"IShowSui", b"The YouTube star IShowSpeed is coming to SUI! Known for his rapid-fire energy and unpredictable antics, he wants to conquer the Sui Network because it matches perfectly with his signature \"SUIIIII!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_f3f8c1204d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

