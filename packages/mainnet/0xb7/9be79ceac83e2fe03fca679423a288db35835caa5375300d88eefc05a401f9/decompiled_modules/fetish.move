module 0xb79be79ceac83e2fe03fca679423a288db35835caa5375300d88eefc05a401f9::fetish {
    struct FETISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FETISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FETISH>(arg0, 9, b"FETISH", b"Footloverz", b"World First ever meme token for our feet lovers explore your inner fantasy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a26a8b70-ee02-4c02-b952-41be704303f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FETISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FETISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

