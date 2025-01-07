module 0xd1390e6d6709b3d8ebd7bcf81fc0e4b21e60db4691060d635f30a300108e2ef1::t0mo {
    struct T0MO has drop {
        dummy_field: bool,
    }

    fun init(arg0: T0MO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0MO>(arg0, 6, b"T0MO", b"TomoSuiFrog", b" TomoSuiFrog waiting for rain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0b1215bac0d620e7f40563e8fe6080ec_bd817dd930.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0MO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T0MO>>(v1);
    }

    // decompiled from Move bytecode v6
}

