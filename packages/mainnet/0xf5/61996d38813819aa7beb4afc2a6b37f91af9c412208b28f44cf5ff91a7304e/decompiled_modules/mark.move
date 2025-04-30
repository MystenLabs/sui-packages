module 0xf561996d38813819aa7beb4afc2a6b37f91af9c412208b28f44cf5ff91a7304e::mark {
    struct MARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARK>(arg0, 6, b"MARK", b"Mark Suckingbird", b"it's just mark sucking bird, no roadmap just pure meme, if you dont buy your mom will not be happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigxjoe56cun6gs64vaahd3rcc6c4yzoa5reoauz6c7ewjo2mp24pi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MARK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

