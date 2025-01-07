module 0x9daa5cd43a42ce8f91f5dc3c9437b579881c9753fd2ede97068e6f7cbf2022e7::kkc {
    struct KKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKC>(arg0, 6, b"KKC", b"Kraken cat", b"kraken and cat are land and sea animals, but we have the best instinct to continue in sui water which is currently cold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042426_67dbe2e147.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

