module 0x9f8e2cb379b5ce480a5c1eca6c770db41dfdc03d2765eb6b02ced9099dd3491e::nigga {
    struct NIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGA>(arg0, 9, b"NIGGA", b"nigga", x"6e69676761e2809973206d656d6520666f722065766572796f6e6520696e636c756465206e696767612070656f706c65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/69534608-79fd-40b9-b51f-a54ef635316f-IMG_3011.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

