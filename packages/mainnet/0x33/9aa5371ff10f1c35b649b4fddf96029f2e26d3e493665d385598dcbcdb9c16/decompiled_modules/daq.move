module 0x339aa5371ff10f1c35b649b4fddf96029f2e26d3e493665d385598dcbcdb9c16::daq {
    struct DAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAQ>(arg0, 6, b"daq", b"daq", b"erdefcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAQ>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAQ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

