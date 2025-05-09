module 0x79f4179c859826c578eb8b2cb84956369adb47d57e5ee75b7ad228c7888b9fae::spinda {
    struct SPINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINDA>(arg0, 6, b"Spinda", b"Spin On SUI", b"Spinda stan | Drunk on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibgbslx74vwr4b3wmgwckwxim3ygulutnxwhgnsjzmvfvc4pshlom")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPINDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

