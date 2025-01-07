module 0xc0bb16648bbe56188e36d42b08f437eb099ea22673454ece9102d666de1d2810::rui {
    struct RUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUI>(arg0, 9, b"RUI", b"Ruimia", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78c19cda-037e-436e-96fe-552d1cf05b72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

