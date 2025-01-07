module 0x82a4d2b3c5ed359a089b589b00bf3643efd615b5658b1836d4623ec580f7a858::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ROCKET>(arg0, 6, b"ROCKET", b"ROCKET", b"SuiEmoji Rocket", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/rocket.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROCKET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

