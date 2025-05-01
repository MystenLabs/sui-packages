module 0x78c2230ec11d7e5a18953d8c98e960425c182ed7bb755cda528c83e9b9e44dae::fine {
    struct FINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINE>(arg0, 6, b"FINE", b"Finecoin", x"4974e28099732066696e652e204974e280997320666972652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746101573688.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

