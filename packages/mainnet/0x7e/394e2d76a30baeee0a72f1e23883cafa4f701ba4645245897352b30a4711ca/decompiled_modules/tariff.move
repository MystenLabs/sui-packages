module 0x7e394e2d76a30baeee0a72f1e23883cafa4f701ba4645245897352b30a4711ca::tariff {
    struct TARIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARIFF>(arg0, 6, b"Tariff", b"Sui Tariffs", x"427265617468696e673f2054617269666665642e0a566962696e673f2054617269666665642e0a53656c6c696e673f205072656d69756d207461726966662e0a0a526f61646d61703a0a0a312e204d696e740a0a322e5461726966662065766572797468696e670a0a0a4261636b65642062793a2050726f6261626c79204e6f7468696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1743707706486.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARIFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARIFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

