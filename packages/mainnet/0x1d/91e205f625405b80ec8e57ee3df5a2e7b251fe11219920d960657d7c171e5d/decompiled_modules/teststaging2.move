module 0x1d91e205f625405b80ec8e57ee3df5a2e7b251fe11219920d960657d7c171e5d::teststaging2 {
    struct TESTSTAGING2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTSTAGING2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741361934757.png"));
        let (v1, v2) = 0x2::coin::create_currency<TESTSTAGING2>(arg0, 6, b"teststaging2", b"teststaging2", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTSTAGING2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTSTAGING2>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTSTAGING2>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTSTAGING2>>(arg0);
    }

    // decompiled from Move bytecode v6
}

