module 0x7e409626a85e648c0716ae4a1ba556f615956936d30ef3480b974d4f8373955::dml {
    struct DML has drop {
        dummy_field: bool,
    }

    fun init(arg0: DML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DML>(arg0, 9, b"DML", b"Dhamal", b"Dhamal is native meme coin on sui blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffdef737-2dba-414b-b3dd-39d5cf735881.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DML>>(v1);
    }

    // decompiled from Move bytecode v6
}

