module 0xa236ef4c214432689687c8d1f03a484583c826c3d6ba4492c8e96622cbbb4d32::asshole {
    struct ASSHOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSHOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSHOLE>(arg0, 6, b"ASSHOLE", b"BONESBONKMAN", b"turbos > hop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731088131742.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSHOLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSHOLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

