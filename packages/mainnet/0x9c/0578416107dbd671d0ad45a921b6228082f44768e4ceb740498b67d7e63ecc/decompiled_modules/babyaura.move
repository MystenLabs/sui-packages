module 0x9c0578416107dbd671d0ad45a921b6228082f44768e4ceb740498b67d7e63ecc::babyaura {
    struct BABYAURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYAURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYAURA>(arg0, 6, b"BABYAURA", b"Baby Aura", b"Baby Aura doesnt invite with words. It glows. And if you re here, it means you re already part of it Just follow the warmth. Thats all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifsqkftz2un2e3brsot575aug3gz7neit7mffp7ocresvh63cff4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYAURA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

