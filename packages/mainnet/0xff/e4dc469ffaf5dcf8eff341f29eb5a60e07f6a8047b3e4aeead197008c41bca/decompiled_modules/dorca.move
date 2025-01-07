module 0xffe4dc469ffaf5dcf8eff341f29eb5a60e07f6a8047b3e4aeead197008c41bca::dorca {
    struct DORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORCA>(arg0, 6, b"Dorca", b"Orca Dog", b"Apex predator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dorka_a1d821bb1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

