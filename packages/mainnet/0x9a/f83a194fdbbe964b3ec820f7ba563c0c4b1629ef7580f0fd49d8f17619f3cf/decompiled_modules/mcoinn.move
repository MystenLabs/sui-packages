module 0x9af83a194fdbbe964b3ec820f7ba563c0c4b1629ef7580f0fd49d8f17619f3cf::mcoinn {
    struct MCOINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCOINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCOINN>(arg0, 9, b"MCOINN", b"Mcoin", b"Mcoin trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3be87d66-200b-4b6e-9e67-a6913fcb91c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCOINN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCOINN>>(v1);
    }

    // decompiled from Move bytecode v6
}

