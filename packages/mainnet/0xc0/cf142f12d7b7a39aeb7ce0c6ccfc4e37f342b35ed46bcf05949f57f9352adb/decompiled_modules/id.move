module 0xc0cf142f12d7b7a39aeb7ce0c6ccfc4e37f342b35ed46bcf05949f57f9352adb::id {
    struct ID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ID>(arg0, 6, b"ID", b"Identity", b"Identity, refers to the qualities, characteristics, or information that define and distinguish an individual, entity, or thing. It answers the question, \"Who or what is this ? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736054608723.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ID>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ID>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

