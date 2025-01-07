module 0x2f55989e57e1ff6fd5fce0449d05adc42dc7c38aafe78a4be9544c3c43d2b20e::edle {
    struct EDLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDLE>(arg0, 6, b"EDLE", b"Edle", x"53756920416d6261737361646f722077697468206d6f7265207468616e2032207965617273206275696c64696e67206f6e2053756920426c6f636b636861696e2e0a45766572797468696e672061626f7574205375692069732068657265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_DB_6d_RC_400x400_710716357f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

