module 0x78934ac59f8122866ee016cb38645dc591359dcb09175985110c4f0ad9bec315::ust {
    struct UST has drop {
        dummy_field: bool,
    }

    fun init(arg0: UST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UST>(arg0, 9, b"UST", b"TRUST", x"f09f87baf09f87b220496e20476f64205765205472757374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5891dae-b4e9-406f-8226-9285ed350ef3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UST>>(v1);
    }

    // decompiled from Move bytecode v6
}

