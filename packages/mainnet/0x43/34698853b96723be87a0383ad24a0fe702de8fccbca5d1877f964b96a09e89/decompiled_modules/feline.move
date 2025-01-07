module 0x4334698853b96723be87a0383ad24a0fe702de8fccbca5d1877f964b96a09e89::feline {
    struct FELINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FELINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FELINE>(arg0, 6, b"FELINE", b"I'M FELINE", x"49274d2046454c494e450a0a594f552752452046656c696e650a0a45564552595448494e472049532046656c696e650a0a4d454f5745", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732553861328.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FELINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FELINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

