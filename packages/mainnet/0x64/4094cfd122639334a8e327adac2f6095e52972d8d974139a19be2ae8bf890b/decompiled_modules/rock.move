module 0x644094cfd122639334a8e327adac2f6095e52972d8d974139a19be2ae8bf890b::rock {
    struct ROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCK>(arg0, 9, b"ROCK", b"New moon", b"Fun for comunity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bf04200-cfbe-4418-80fb-c737ee3db23b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

