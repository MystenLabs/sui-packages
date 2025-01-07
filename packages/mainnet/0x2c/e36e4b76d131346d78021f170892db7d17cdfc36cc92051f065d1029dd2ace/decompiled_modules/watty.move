module 0x2ce36e4b76d131346d78021f170892db7d17cdfc36cc92051f065d1029dd2ace::watty {
    struct WATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATTY>(arg0, 6, b"Watty", b"Water Meme", b"The real MEME on water chain. Our fuel is WATER, let the water out. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734493252937.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

