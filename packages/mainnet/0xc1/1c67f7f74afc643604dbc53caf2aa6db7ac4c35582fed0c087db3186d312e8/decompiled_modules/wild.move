module 0xc11c67f7f74afc643604dbc53caf2aa6db7ac4c35582fed0c087db3186d312e8::wild {
    struct WILD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILD>(arg0, 6, b"WILD", b"Wild Guyz", b"Young, wild and free!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wg_def10566e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILD>>(v1);
    }

    // decompiled from Move bytecode v6
}

