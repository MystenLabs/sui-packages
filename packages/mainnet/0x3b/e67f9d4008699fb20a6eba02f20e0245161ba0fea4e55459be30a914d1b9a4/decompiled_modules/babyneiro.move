module 0x3be67f9d4008699fb20a6eba02f20e0245161ba0fea4e55459be30a914d1b9a4::babyneiro {
    struct BABYNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYNEIRO>(arg0, 9, b"BABYNEIRO", b"Baby", x"23446f67652c202342616279446f67652c20616e64206e6f772023426162794e6569726f3f2049742773206c696b6520612066616d696c79207265756e696f6e2c2062757420426162796e6569726f2077696c6c2074616b6520666972737420706c616365f09f94a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1be9bf8c-a887-4f2e-bcf7-4fcebca96dda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

