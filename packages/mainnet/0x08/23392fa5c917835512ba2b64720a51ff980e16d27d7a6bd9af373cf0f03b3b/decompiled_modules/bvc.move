module 0x823392fa5c917835512ba2b64720a51ff980e16d27d7a6bd9af373cf0f03b3b::bvc {
    struct BVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVC>(arg0, 9, b"BVC", b"DF", b"VC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3018f033-1091-4e14-854e-5b4ab8562208.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

