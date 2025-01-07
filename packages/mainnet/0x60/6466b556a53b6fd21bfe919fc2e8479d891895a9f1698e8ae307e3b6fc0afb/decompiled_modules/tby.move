module 0x606466b556a53b6fd21bfe919fc2e8479d891895a9f1698e8ae307e3b6fc0afb::tby {
    struct TBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBY>(arg0, 9, b"TBY", b"Tobby", b"A Meme Token for Tobby and Community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d7c054c-8181-490f-96e5-d17050e74882.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

