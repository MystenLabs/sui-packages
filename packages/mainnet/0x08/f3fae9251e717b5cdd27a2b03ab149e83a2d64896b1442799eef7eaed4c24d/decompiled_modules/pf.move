module 0x8f3fae9251e717b5cdd27a2b03ab149e83a2d64896b1442799eef7eaed4c24d::pf {
    struct PF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PF>(arg0, 9, b"PF", b"POCKETFI", b"POCKETFI BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2e27069-5749-4fa0-aed0-1aa58be708d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PF>>(v1);
    }

    // decompiled from Move bytecode v6
}

