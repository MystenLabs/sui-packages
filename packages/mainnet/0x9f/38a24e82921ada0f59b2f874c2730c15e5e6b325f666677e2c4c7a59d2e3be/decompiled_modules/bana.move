module 0x9f38a24e82921ada0f59b2f874c2730c15e5e6b325f666677e2c4c7a59d2e3be::bana {
    struct BANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANA>(arg0, 9, b"BANA", b"Banana", b"BANANA BANANANANA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fb07a5c-bf86-4e21-98bf-56e0c1676184.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

