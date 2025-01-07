module 0xa8f5fdd0a64032bd6e3915efcdf298bc5772d1eaf779b949a43d358dbd02ed17::winnie {
    struct WINNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINNIE>(arg0, 9, b"Winnie", b"New Tiktok Doge", b"Winnie, The new Doge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FJnp1PVACbtMWyWwZfsqzJgxZBZpvXuz288GjZ9ypump.png?size=xl&key=2e696e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WINNIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINNIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINNIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

