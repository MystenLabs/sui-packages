module 0xec4e1e734189cd9260704e9ea5ac1113cc678ba959af2e0e18f6ea68be95684a::justin {
    struct JUSTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTIN>(arg0, 9, b"JUSTIN", b"Jb", b"Lonely", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9ad11b2-bc14-4949-91e6-a025c0df4b5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUSTIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

