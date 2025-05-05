module 0x52523e78e1baad8fbdc6c4be1e808d335223c67690c5e99091f329c7c00231d2::eskimo {
    struct ESKIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESKIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESKIMO>(arg0, 6, b"ESKIMO", b"DOGGY", b"My dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiggphuhjo3hzivf4moutmzafklqnsccqlzo7zdekk47oa24kjpwku")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESKIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ESKIMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

