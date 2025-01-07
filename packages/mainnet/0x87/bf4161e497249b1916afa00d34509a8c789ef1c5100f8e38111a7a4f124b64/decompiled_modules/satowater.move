module 0x87bf4161e497249b1916afa00d34509a8c789ef1c5100f8e38111a7a4f124b64::satowater {
    struct SATOWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOWATER>(arg0, 6, b"Satowater", b"Peter Todds Bottle of Water", x"506574657220546f64647320426f74746c65206f6620576174657220287469636b65723a205361746f776174657229204675636b2074686520706574732c206c6574732073656e64205361746f7368697320626f74746c65206f66207761746572210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_at_14_48_18_152dedaf35.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

