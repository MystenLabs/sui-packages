module 0xd50bc08cdf82d2504583ad8cf215316e90dfaa3c98c57ccfbb39e6524e638cf1::drts {
    struct DRTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRTS>(arg0, 9, b"DRTS", b"DARTS", b"try to be precise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c58cec76-3b77-4a33-82d0-ad31906a94e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

