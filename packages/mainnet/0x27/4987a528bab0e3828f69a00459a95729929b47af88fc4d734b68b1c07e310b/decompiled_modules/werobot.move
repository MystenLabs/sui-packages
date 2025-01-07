module 0x274987a528bab0e3828f69a00459a95729929b47af88fc4d734b68b1c07e310b::werobot {
    struct WEROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEROBOT>(arg0, 9, b"WEROBOT", b"Optimus ", x"4d656d6520696e73706972656420627920456c6f6e204d75736b202d205465736c612773204f7074696d75732047656e6572616c20507572706f73652c2042692d706564616c2c2048756d616e6f696420726f626f742063617061626c65206f6620706572666f726d696e67207461736b7320746861742061726520756e736166652c2072657065746974697665206f7220626f72696e672e20f09f938820f09fa496", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/089c04d4-cf9d-4c80-b05c-44e7cce442ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

