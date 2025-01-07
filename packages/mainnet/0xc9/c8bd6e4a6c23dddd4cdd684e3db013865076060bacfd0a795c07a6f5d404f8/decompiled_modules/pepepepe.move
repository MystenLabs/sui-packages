module 0xc9c8bd6e4a6c23dddd4cdd684e3db013865076060bacfd0a795c07a6f5d404f8::pepepepe {
    struct PEPEPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEPEPE>(arg0, 6, b"PEPEPEPE", b"PepePepePepePepePepe", b"PepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePepePe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732290465226.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

