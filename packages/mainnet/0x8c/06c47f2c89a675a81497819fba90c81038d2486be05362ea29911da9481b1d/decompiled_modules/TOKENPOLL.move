module 0x8c06c47f2c89a675a81497819fba90c81038d2486be05362ea29911da9481b1d::TOKENPOLL {
    struct TOKENPOLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENPOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741064934224.png"));
        let (v1, v2) = 0x2::coin::create_currency<TOKENPOLL>(arg0, 6, b"testlai", b"tokenpoll", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENPOLL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKENPOLL>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TOKENPOLL>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKENPOLL>>(arg0);
    }

    // decompiled from Move bytecode v6
}

