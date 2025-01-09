module 0x3ed88d9ef795749ae14f9ffbb0a9b4d585388c264bacef59f11147f842b642b9::glc {
    struct GLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLC>(arg0, 6, b"GLC", b"GigaLulCoin", b"Buckle up, meme-lords and crypto-enthusiasts! Join us on a wild ride with GigaLulCoin on the Sui protocol! It's gonna be a laugh-riot with gains so high, you'll think you're dreaming! Don't miss the moonshot - hop on board now for the adventure of a ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736413971500.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

