module 0xe0f83f65a48492d7477b43127624ee6dd60e2689d3360282328c565cbb2151af::neko {
    struct NEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKO>(arg0, 9, b"NEKO", b"Neko Neko", b"Neko Neko Neko", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeihdots7olaoa3qwlhwkapftzmzkri4uoxxhkcalxyhvkr4hjf27je.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEKO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

