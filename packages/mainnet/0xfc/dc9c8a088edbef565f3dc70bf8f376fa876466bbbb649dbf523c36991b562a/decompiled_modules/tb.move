module 0xfcdc9c8a088edbef565f3dc70bf8f376fa876466bbbb649dbf523c36991b562a::tb {
    struct TB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TB>(arg0, 6, b"TB", b"Turbos", x"54686520756c74696d617465206173736574206d616e6167656d656e742c2074726164696e67206761746577617920616e64206d656d652068756220666f72200a405375694e6574776f726b0a2c20706f776572656420627920436f6e63656e747261746564204c6971756964697479204d61726b6574204d616b696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731016712435.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

