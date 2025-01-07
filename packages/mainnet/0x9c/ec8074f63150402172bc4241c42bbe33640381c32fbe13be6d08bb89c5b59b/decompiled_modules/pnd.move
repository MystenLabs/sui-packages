module 0x9cec8074f63150402172bc4241c42bbe33640381c32fbe13be6d08bb89c5b59b::pnd {
    struct PND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PND>(arg0, 9, b"PND", b"panda", x"476f2077696c6420776974682050616e6461436f696e3a2054686520637564646c792063727970746f63757272656e6379207468617427732062616d626f6f2d73686f6f74696e672070726f6669747320616e64206272696e67696e67206120746f756368206f6620706c617966756c20636861726d20746f20796f757220706f7274666f6c696f20f09f90bc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56c03266-42bb-4c5a-a12b-45a3a1994f1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PND>>(v1);
    }

    // decompiled from Move bytecode v6
}

