module 0x4e4bdcbb6866fac806f0eeb9434c1be7c3ac936ea6f9ca1ca8571d889c360d60::gffg {
    struct GFFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFFG>(arg0, 9, b"GFFG", b"HJH", b"ERTR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/120363da-d49e-43a0-a35f-90b0a144ce66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

