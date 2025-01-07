module 0xc91e5ef2ef6788ffebd41f372f65c344c53167d3e0bff11a404c63f0a2792c39::fire {
    struct FIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FIRE>(arg0, 6, b"FIRE", b"FIRE", b"SuiEmoji Fire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/fire.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIRE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

