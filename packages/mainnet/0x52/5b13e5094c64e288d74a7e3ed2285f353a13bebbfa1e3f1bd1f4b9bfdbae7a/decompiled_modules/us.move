module 0x525b13e5094c64e288d74a7e3ed2285f353a13bebbfa1e3f1bd1f4b9bfdbae7a::us {
    struct US has drop {
        dummy_field: bool,
    }

    fun init(arg0: US, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<US>(arg0, 6, b"US", b"UNITED STATES FLAG", b"SuiEmoji United States Flag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/us.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<US>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<US>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

