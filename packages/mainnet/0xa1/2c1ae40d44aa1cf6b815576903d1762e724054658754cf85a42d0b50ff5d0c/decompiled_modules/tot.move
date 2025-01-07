module 0xa12c1ae40d44aa1cf6b815576903d1762e724054658754cf85a42d0b50ff5d0c::tot {
    struct TOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOT>(arg0, 9, b"TOT", b"TOOT", x"496e74726f647563696e6720544f4f5420f09f9a80f09f92a8e28094746865206d656d6520636f696e206272696e67696e672066756e20616e6420706f74656e7469616c206761696e7320746f2063727970746f21204a6f696e206120636f6d6d756e697479206675656c6564206279206c61756768732c20637265617469766974792c20616e64206d6f6f6e2d626f756e6420647265616d732e20544f4f542069736ee2809974206a757374206120636f696e3b206974e28099732061206d6f76656d656e7420666f722074686f73652077686f2077616e7420746f20484f444c20616e642068617665206120676f6f642074696d652e20f09f8c95f09f92a52023544f4f54", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1003477-c2ae-4ddc-9351-a35cff177515.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

