module 0x576e053c921771ef984fd207b3971054d99b234ac17ac10685b0088a22794de3::rct {
    struct RCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCT>(arg0, 9, b"RCT", b"Roccat", x"526f6363617420746f20746865206d6f6f6e20f09f9a80f09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97e2e27a-551b-444b-81f9-bba72b69a41e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

