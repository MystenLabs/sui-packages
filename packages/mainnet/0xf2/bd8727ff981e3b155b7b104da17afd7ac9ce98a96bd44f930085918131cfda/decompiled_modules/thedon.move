module 0xf2bd8727ff981e3b155b7b104da17afd7ac9ce98a96bd44f930085918131cfda::thedon {
    struct THEDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEDON>(arg0, 9, b"THEDON", b"The Donald", b"Rogan and Trump 2024!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0765a52-8dc2-44ee-9c1b-d28002afcef2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

