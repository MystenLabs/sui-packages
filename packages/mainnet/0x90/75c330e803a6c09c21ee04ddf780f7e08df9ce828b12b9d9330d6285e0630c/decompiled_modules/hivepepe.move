module 0x9075c330e803a6c09c21ee04ddf780f7e08df9ce828b12b9d9330d6285e0630c::hivepepe {
    struct HIVEPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIVEPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIVEPEPE>(arg0, 6, b"HIVEPEPE", b"Hive Pepe AI", b"Just A Hive Pepe AI Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hive_bd25b6ef5e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIVEPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIVEPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

