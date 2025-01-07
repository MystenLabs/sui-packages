module 0xa53283bbf6b6986dac339a6980fcf70d3db12ed3ea70b62b11059205a4217d90::sonic {
    struct SONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONIC>(arg0, 6, b"SONIC", b"Sonic on Sui", x"476f74746120676f206661737420776974682024534f4e4943206f6e2053756921205468697320636f696e20737065656473207468726f7567682074686520626c6f636b636861696e206c696b652074686520626c7565206865646765686f672068696d73656c662e204e6f206f6e652063616e2063617463682074686973206f6e652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sonic_85d40414de.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

