module 0x7c65b0cc4960e73ec0604661c8444cd45293ef4f3c412e94f02b4eff2566ef00::vale {
    struct VALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VALE>(arg0, 6, b"Vale", b"Vale Coin", b"Vale Coin: In honor of the charming Valentina, Vale Coin celebrates the elegance and grace of a woman who knows her worth. After all, when life gives you lemons, create a cryptocurrency! With Vale Coin, you can join a community that appreciates beauty and strength. Because in the world of Vale, every transaction is a statement of independence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000255232_d5fe285c89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

