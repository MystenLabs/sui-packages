module 0x9536b15952b4b6d8f6101c6688eb95949a07cc25642ab1df4a8592de6ece9d6::coffeee {
    struct COFFEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFEEE>(arg0, 9, b"COFFEEE", b"Coffee", b"The best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc3f450f-0e43-4e32-88eb-fc7f62a25f2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COFFEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

