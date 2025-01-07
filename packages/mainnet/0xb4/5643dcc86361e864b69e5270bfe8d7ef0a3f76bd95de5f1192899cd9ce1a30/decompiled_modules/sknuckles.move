module 0xb45643dcc86361e864b69e5270bfe8d7ef0a3f76bd95de5f1192899cd9ce1a30::sknuckles {
    struct SKNUCKLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKNUCKLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKNUCKLES>(arg0, 6, b"SKnuckles", b"Sui Knuckles", b"Do u no da wey ?da wey is su", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_2024_10_19_T015241_243_09f6ba4356.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKNUCKLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKNUCKLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

