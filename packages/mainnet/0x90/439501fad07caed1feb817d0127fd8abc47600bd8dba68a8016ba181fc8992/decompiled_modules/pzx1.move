module 0x90439501fad07caed1feb817d0127fd8abc47600bd8dba68a8016ba181fc8992::pzx1 {
    struct PZX1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PZX1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PZX1>(arg0, 9, b"PZX1", b"Pezxi", b"This token is inspired by technological trend embodied in AI generated Steele that will definitely make financial impact in a positive way. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a20c46f-098a-48de-9e37-6c8ffd1215ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PZX1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PZX1>>(v1);
    }

    // decompiled from Move bytecode v6
}

