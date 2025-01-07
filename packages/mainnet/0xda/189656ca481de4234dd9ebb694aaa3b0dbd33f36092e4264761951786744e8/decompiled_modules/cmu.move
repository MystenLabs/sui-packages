module 0xda189656ca481de4234dd9ebb694aaa3b0dbd33f36092e4264761951786744e8::cmu {
    struct CMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMU>(arg0, 9, b"CMU", b"COMU", x"556e69746520796f757220696e766573746d656e7473207769746820436f6d75436f696e3a2054686520636f6c6c61626f7261746976652063727970746f63757272656e637920746861742773206275696c64696e6720636f6d6d756e697479207765616c746820f09fa49df09fa49df09fa49df09fa49df09fa49df09fa49df09fa49df09fa49d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/187ee9ad-947d-47fa-9d71-a1869840cdd8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

