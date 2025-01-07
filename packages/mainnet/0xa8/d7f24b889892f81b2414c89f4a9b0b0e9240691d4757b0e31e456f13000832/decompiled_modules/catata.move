module 0xa8d7f24b889892f81b2414c89f4a9b0b0e9240691d4757b0e31e456f13000832::catata {
    struct CATATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATATA>(arg0, 6, b"Catata", b"Catatafish", b"Holy Catatafish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_07_012041_3bd04c3589.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

