module 0x20ebadb2a2380688195c3b27c6eada7a50611fefae7488ba632c7713bbb7bf5a::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"NOVA", b"NovaTale", b"NovaTale AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaenutphh5kdbblw4m63rqv5mzat3pcjcxhf7j6cdftwe5v6hi7dm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOVA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

