module 0x5324fca8ad988ed3cdb9d20f7d3375984bd8b0d696472083a223bc2cd6690999::huhcat {
    struct HUHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUHCAT>(arg0, 9, b"HUHCAT", b"HUHCATS", b"Huh?Huh?Huh?Buhhhhh!!! Tokens by HUHCATS_SOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ecbe290b-e773-4180-97d7-a57202c2a7ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

