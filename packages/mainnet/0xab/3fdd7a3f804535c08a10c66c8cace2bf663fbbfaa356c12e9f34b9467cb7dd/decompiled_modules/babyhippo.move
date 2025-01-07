module 0xab3fdd7a3f804535c08a10c66c8cace2bf663fbbfaa356c12e9f34b9467cb7dd::babyhippo {
    struct BABYHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYHIPPO>(arg0, 6, b"BABYHIPPO", b"BabySudeng", x"42616279537544656e672069732074686520637574657374202442414259484950504f206f6e205355492c206272696e67696e67202442414259484950504f20746f2074686520776f726c64206f66206d656d65732e0a0a4e6f20636174732c206e6f20646f67732e204f6e6c79202442414259484950504f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731498014433.41")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYHIPPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYHIPPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

