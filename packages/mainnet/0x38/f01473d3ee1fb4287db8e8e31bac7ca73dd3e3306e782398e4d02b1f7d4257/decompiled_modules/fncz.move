module 0x38f01473d3ee1fb4287db8e8e31bac7ca73dd3e3306e782398e4d02b1f7d4257::fncz {
    struct FNCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNCZ>(arg0, 9, b"FNCZ", b"KONz", b"Smoking is harmful to health, everyone should not smoke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa254d53-8eaa-462c-a924-cf1524c53d80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

