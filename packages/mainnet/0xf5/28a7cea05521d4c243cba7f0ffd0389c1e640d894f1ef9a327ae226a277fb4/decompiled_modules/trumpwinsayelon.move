module 0xf528a7cea05521d4c243cba7f0ffd0389c1e640d894f1ef9a327ae226a277fb4::trumpwinsayelon {
    struct TRUMPWINSAYELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWINSAYELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWINSAYELON>(arg0, 6, b"TrumpWinSayElon", b"Trump win-Elon", b"Elon musk say Donald Trump win, and Elon support Trump. Elon also funding Donald trump Party.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elon_and_Trump_d811e07d4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWINSAYELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPWINSAYELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

