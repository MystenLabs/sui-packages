module 0xcd05f68af132f65fbc53385b567b98b17526a946c417ece989b0ad4601b3612e::tlife {
    struct TLIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLIFE>(arg0, 9, b"TLIFE", b"Token Life", b"Just a token for a good life ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c37d0dc9-4ae2-4958-bbff-d44c0ac98e05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TLIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

