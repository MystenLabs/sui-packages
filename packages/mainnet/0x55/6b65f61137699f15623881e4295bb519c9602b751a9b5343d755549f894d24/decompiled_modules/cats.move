module 0x556b65f61137699f15623881e4295bb519c9602b751a9b5343d755549f894d24::cats {
    struct CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS>(arg0, 9, b"CATS", b"Shitcats", x"f09f908820676f20746f6f206d6f6f6e20f09f8c9920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9da07efb-e5fd-409d-aa03-cd9d76e1aa77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

