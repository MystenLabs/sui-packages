module 0x5d3e435067491b32b8b05d36dabbc28cceb91d63dec88c928fdc0bf4cd6630e7::egbz {
    struct EGBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGBZ>(arg0, 9, b"EGBZ", b"E G B Z", b"'EGBGZ'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/beca312e-5ad3-41c9-9819-5060f6c7035c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGBZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

