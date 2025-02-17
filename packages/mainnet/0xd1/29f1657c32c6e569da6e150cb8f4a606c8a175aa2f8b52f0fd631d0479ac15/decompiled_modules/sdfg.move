module 0xd129f1657c32c6e569da6e150cb8f4a606c8a175aa2f8b52f0fd631d0479ac15::sdfg {
    struct SDFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFG>(arg0, 9, b"cvbx", b"ds", x"c491", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"dd")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDFG>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDFG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SDFG>>(v2);
    }

    // decompiled from Move bytecode v6
}

