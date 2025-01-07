module 0xf3f1f4e4390cc3165c2f3fe32364f509b02c6132cc4bba0fa6b93b09635ba89::mineow {
    struct MINEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINEOW>(arg0, 6, b"MINEOW", b"Mineow", b"I'm a minnow that meows. Mineow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mineow_b505fb8719.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

