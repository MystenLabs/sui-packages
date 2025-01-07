module 0x5e0b311f83f27001d697d65206d0d313c6c302a5d559571dcede056f805bb48::rrr {
    struct RRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRR>(arg0, 9, b"RRR", b"EE", b"VVV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/092be284-3b8d-4c93-99af-a503855e1255.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

