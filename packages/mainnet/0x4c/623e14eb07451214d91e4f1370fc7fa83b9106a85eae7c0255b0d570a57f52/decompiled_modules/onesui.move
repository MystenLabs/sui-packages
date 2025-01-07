module 0x4c623e14eb07451214d91e4f1370fc7fa83b9106a85eae7c0255b0d570a57f52::onesui {
    struct ONESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONESUI>(arg0, 6, b"ONESUI", b"just buy 1SUI worth of this coin", x"6a75737420627579203173756920776f727468206f66207468697320636f696e0a0a496c6c206a75737420627579203120737569207468656e20646f206d61726b6574696e670a0a696c6c206d616b652067726f757020616e64207765627369746520666f7220746869730a0a4a55535420484f444c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_sui_coin_9177503_7479564_0f5e29e60c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

