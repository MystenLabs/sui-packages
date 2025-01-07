module 0x9eee0ce4c3ac3234cd7c229469590228886e33fe3848c67ddc3212147c3cd66c::hodlm {
    struct HODLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODLM>(arg0, 9, b"HODLM", b"Hodlmeme", x"4a757374206d656d6520666f722074686520576f726c64206f662063727970746f207768657265207765206861766520746865206d6f73742066756e2e204c657427732073656e64207468697320746f20746865206d6f6f6e20f09f8c9d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10f66dcd-8169-4ba0-86cd-ce1e7dee4130.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HODLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

