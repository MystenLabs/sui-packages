module 0xa8e5127ae6fa1a1bf053aef3f5f8a2ddcf66f84426e782e0beba3b8daf42abe0::mskrt {
    struct MSKRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSKRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSKRT>(arg0, 6, b"MSKRT", b"MUSKRAT", x"41667465722067656e65746963616c6c79206d657267696e6720776974682047726f6b2c205465736c61206175746f70696c6f742c20616e6420446f67652d34322c20456c6f6e204d75736b206163686965766573206869732066696e616c20666f726d20e28094204d75736b72617420e28094206120646174612d686f617264696e672c204d6172732d626f756e6420726f64656e742d6379626f726720746861742074776565747320696e204d6f72736520636f646520616e64207269677320657665727920636861727420776974682070757265206d656d6520656e657267792e204865206d696e657320446f6765636f696e7320776974682068", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748537034002.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSKRT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSKRT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

