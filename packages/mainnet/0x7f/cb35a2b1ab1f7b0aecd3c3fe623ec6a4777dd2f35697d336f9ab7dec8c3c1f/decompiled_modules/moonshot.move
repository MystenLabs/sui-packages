module 0x7fcb35a2b1ab1f7b0aecd3c3fe623ec6a4777dd2f35697d336f9ab7dec8c3c1f::moonshot {
    struct MOONSHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONSHOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONSHOT>(arg0, 9, b"MOONSHOT", b"MSHOT", x"57656c636f6d6520746f204d6f6f6e73686f7420e2809320546865204e65787420426967204d656d6520436f696e2054686174e280997320526561647920746f20526f636b657420746f20746865204d6f6f6e2120f09f9a806c696d6974656420737570706c792c207374726f6e6720636f6d6d756e6974792c20616e6420636c656172204d6f6f6e73686f7420697320706f736974696f6e656420666f72206578706c6f736976652067726f7774682e204f7572206d697373696f6e2069732073696d706c653a203130307820706f74656e7469616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07f2421a-d4e1-4dc3-bcbd-b1eec1f3f44c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONSHOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONSHOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

