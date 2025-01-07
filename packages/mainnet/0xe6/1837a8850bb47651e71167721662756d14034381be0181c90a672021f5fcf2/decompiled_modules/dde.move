module 0xe61837a8850bb47651e71167721662756d14034381be0181c90a672021f5fcf2::dde {
    struct DDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDE>(arg0, 9, b"DDE", b"RED", b"RED GAME ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef58a061-0676-452c-98df-e07cf3828962.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

