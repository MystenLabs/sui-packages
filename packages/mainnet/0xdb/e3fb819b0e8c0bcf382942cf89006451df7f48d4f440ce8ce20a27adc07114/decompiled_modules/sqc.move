module 0xdbe3fb819b0e8c0bcf382942cf89006451df7f48d4f440ce8ce20a27adc07114::sqc {
    struct SQC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQC>(arg0, 6, b"SQC", b"Square Cat", b"This is the first square cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12112_96a4a450d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQC>>(v1);
    }

    // decompiled from Move bytecode v6
}

