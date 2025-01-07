module 0x78f26fc7dad5cb7fd672dc6509f1b0909dc5ca514f614349fbde1a9244013c34::flare {
    struct FLARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLARE>(arg0, 9, b"FLARE", b"Sunshine", b"https://t.me/flarexgamebot?start=6678236c7679f0d88320a7c9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0223d41b-f4ee-4045-a39d-0a38a93f72c5-1001483140.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLARE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLARE>>(v1);
    }

    // decompiled from Move bytecode v6
}

