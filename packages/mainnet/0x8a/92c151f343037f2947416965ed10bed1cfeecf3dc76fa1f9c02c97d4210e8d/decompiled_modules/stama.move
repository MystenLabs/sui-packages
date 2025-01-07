module 0x8a92c151f343037f2947416965ed10bed1cfeecf3dc76fa1f9c02c97d4210e8d::stama {
    struct STAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAMA>(arg0, 6, b"STAMA", b"SUITAMA", b"SUITAMA can destroy all other memecoins with just one punch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731069658519.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

