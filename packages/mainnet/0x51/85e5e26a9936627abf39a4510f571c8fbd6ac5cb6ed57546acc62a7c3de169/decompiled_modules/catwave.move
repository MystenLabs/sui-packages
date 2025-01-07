module 0x5185e5e26a9936627abf39a4510f571c8fbd6ac5cb6ed57546acc62a7c3de169::catwave {
    struct CATWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWAVE>(arg0, 9, b"CATWAVE", x"5741564520f09f8c8a", x"4c6f6f6b696e6720746f2063726561746520756e69717565206d656d657320666173743f204272696e6720796f757220696465617320746f205761766550756d702c20636c69636b2061206665772074696d65732c20616e64e28094626f6f6d21204d656d6520746f6b656e206d6164652e205761766550756d702073617665732074696d6520666f7220626567696e6e65727320616e64204f477320616c696b6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c84fd1a-21ec-4f75-9992-74968bb829ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

