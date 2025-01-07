module 0x5fc160bebb0827123fd40aa32cd6f66927cb833ffcfd118c5a1fd925833a61ee::patrick {
    struct PATRICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATRICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATRICK>(arg0, 9, b"PATRICK", b"Patrick", b"Patrick is Spongebob's very funny friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c55314d-9299-4473-8c0b-cab1c9e57185.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATRICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PATRICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

