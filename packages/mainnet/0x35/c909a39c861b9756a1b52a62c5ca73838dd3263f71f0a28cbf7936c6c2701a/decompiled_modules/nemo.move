module 0x35c909a39c861b9756a1b52a62c5ca73838dd3263f71f0a28cbf7936c6c2701a::nemo {
    struct NEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMO>(arg0, 6, b"NEMO", b"Nemo Protocol", x"546865207969656c642074726164696e6720617070206f6e20537569204e6574776f726b0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736050756494.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

