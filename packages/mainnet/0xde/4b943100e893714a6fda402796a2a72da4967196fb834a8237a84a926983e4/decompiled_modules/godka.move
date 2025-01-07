module 0xde4b943100e893714a6fda402796a2a72da4967196fb834a8237a84a926983e4::godka {
    struct GODKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODKA>(arg0, 9, b"GODKA", b"MAJOR GOD", b"God Of David Bullrun Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31a5dcb1-7304-4380-850c-396f44e27550.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

