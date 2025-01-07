module 0xc938ba0af333e7946b9c43ca39978049cd28c0993c55be595dbc62c886fa27fb::maneki {
    struct MANEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANEKI>(arg0, 9, b"MANEKI", b"MANEKI ", b"First MANEKI NEKO on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3dc1bfb8-e535-47e1-b6ed-fb14065b16aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

