module 0xe329acc0bb5bbecc3f174b5e8ceb59f5c948972f00904e716ab388a2d6385593::slapcoin {
    struct SLAPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAPCOIN>(arg0, 6, b"SLAPCOIN", b"Slapcoin", b"Slap it?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4356_cbb8621829.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

