module 0xd3a20c62473c6e0a40d6b365cf80f44c4cf544f40e43bbcbce16e4780780a0b2::zs {
    struct ZS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZS>(arg0, 9, b"ZS", b"ZEUS", b"keep pushing until you cum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bc77f50-f4f3-49ba-9004-c309bf4cf0bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZS>>(v1);
    }

    // decompiled from Move bytecode v6
}

