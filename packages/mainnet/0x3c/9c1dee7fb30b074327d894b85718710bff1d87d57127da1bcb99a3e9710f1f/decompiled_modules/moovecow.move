module 0x3c9c1dee7fb30b074327d894b85718710bff1d87d57127da1bcb99a3e9710f1f::moovecow {
    struct MOOVECOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOVECOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOVECOW>(arg0, 6, b"MOOVECOW", b"MOOVEC0W ", b"When the farmer's away,  MOOVECOW play. Can't stop won't stop just keep on moo-ving. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985629948.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOOVECOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOVECOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

