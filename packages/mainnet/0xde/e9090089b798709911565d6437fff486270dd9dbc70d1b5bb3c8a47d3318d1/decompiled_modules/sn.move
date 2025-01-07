module 0xdee9090089b798709911565d6437fff486270dd9dbc70d1b5bb3c8a47d3318d1::sn {
    struct SN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SN>(arg0, 9, b"SN", b"SieuNhan", x"48e1bb9969206165207468c3ad6368207369c3aa75206e68c3a26e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe39931c-8ff0-4686-8a50-2d3d99c70170.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SN>>(v1);
    }

    // decompiled from Move bytecode v6
}

