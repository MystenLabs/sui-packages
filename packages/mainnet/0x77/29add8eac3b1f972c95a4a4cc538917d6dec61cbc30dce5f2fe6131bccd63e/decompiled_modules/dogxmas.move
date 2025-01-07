module 0x7729add8eac3b1f972c95a4a4cc538917d6dec61cbc30dce5f2fe6131bccd63e::dogxmas {
    struct DOGXMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGXMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGXMAS>(arg0, 6, b"DogxMas", b"Dog Christmas Gifts", x"4e6f205574696c6974790a4f6e6c79205072657061726520666f7220796f757220446f672043687269736d617320476966742e0a0a5065747320446f6720436f6d6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732614808965.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGXMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGXMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

