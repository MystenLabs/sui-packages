module 0x40aa3fe84507d541f97454a85e0d4d76811f6d6c210d6886f97c3f948f679499::makafo {
    struct MAKAFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKAFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKAFO>(arg0, 6, b"MAKAFO", b"Makafo", x"417320616972206d6f766573206261636b20616e6420666f727468206265747765656e20746865206c756e6773206f66207468652066726f6720616e642074686520766f63616c207361632c2074686520766f63616c20636f726473206361757365207468652061697220746f207669627261746520616e642070726f64756365207468652063726f616b696e6720736f756e642074686174207765206865617220244d414b41464f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmahtq_Wus_Se_E5to2_BW_83_C_Lny_Ho_AWX_4h3kw_Qmg6o_MGCC_6k4_32513487ab.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKAFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAKAFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

