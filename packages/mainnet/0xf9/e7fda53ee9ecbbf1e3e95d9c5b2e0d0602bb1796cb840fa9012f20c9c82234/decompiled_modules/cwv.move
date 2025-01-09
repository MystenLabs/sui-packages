module 0xf9e7fda53ee9ecbbf1e3e95d9c5b2e0d0602bb1796cb840fa9012f20c9c82234::cwv {
    struct CWV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWV>(arg0, 9, b"CWV", b"CatWave", x"e2809c496e74726f647563696e67204361745761766520284357562920e28093207468652063727970746f20746f6b656e2074686174206c65747320796f752072696465207468652077617665732077697468206120636174e280997320706c617966756c20636861726d2120f09f90b1f09f92b820536d6f6f7468207472616e73616374696f6e732c206e6f206472616d612c206a75737420707572652066756e20616e642070726f666974732e2053757266207468652063727970746f20776f726c642077697468204361745761766520616e64206665656c20746865207669626521e2809d20f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b2840e6-9b95-41ec-a92b-3be3e34affa7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CWV>>(v1);
    }

    // decompiled from Move bytecode v6
}

