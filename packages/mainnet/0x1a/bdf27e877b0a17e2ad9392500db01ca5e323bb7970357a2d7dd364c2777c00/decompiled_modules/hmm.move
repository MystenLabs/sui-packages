module 0x1abdf27e877b0a17e2ad9392500db01ca5e323bb7970357a2d7dd364c2777c00::hmm {
    struct HMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMM>(arg0, 6, b"HMM", b"HHMMMMMMMMMMMMMM", b"Hmm... what's that sound? Is it the moon calling? Nope. It's just running for absolutely no reason.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hummm_7fceed15d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

