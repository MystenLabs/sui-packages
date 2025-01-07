module 0xfdd62b215cbca0c2706557dc4cec7d262d1c6bf668bce5a3ef788b4672b4c2dd::liquor {
    struct LIQUOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQUOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQUOR>(arg0, 6, b"Liquor", b"BeLiquorOnSui", b"Be water, be liquor, my friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_040043_da2f115e5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQUOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQUOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

