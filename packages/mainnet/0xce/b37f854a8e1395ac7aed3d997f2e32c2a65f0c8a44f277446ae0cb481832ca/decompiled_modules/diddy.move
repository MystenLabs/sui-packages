module 0xceb37f854a8e1395ac7aed3d997f2e32c2a65f0c8a44f277446ae0cb481832ca::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 6, b"DIDDY", b"Nice Try, Diddy", b"DIDDY TO MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951453653.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

