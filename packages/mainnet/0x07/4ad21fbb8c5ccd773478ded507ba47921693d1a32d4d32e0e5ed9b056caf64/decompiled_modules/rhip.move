module 0x74ad21fbb8c5ccd773478ded507ba47921693d1a32d4d32e0e5ed9b056caf64::rhip {
    struct RHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHIP>(arg0, 6, b"RHip", b"running hippo", b"This is the first sui meme token for running hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hippo_run_cc23d43ea8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

