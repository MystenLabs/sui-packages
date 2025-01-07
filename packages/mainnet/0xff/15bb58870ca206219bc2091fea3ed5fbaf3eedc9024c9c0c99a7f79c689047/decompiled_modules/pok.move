module 0xff15bb58870ca206219bc2091fea3ed5fbaf3eedc9024c9c0c99a7f79c689047::pok {
    struct POK has drop {
        dummy_field: bool,
    }

    fun init(arg0: POK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POK>(arg0, 6, b"Pok", b"Pokhi Pakhi", b"Good Projects ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736260782287.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

