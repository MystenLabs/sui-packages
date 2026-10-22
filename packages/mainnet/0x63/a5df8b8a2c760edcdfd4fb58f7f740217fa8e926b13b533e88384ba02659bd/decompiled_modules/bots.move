module 0x63a5df8b8a2c760edcdfd4fb58f7f740217fa8e926b13b533e88384ba02659bd::bots {
    struct BOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTS>(arg0, 6, b"BOTS", b"CONSO BOTs", b"Official CONSO BOTs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1792681618276.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

