module 0xb46ca01001e73934eb9ec7dcdf32fb2175df6c96fd0676e3cab37eb80c481ae2::suiwmn {
    struct SUIWMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWMN>(arg0, 6, b"SUIWMN", b"suiwoman", b"suiwoman here to save the day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_071956_9a1cb64058.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

