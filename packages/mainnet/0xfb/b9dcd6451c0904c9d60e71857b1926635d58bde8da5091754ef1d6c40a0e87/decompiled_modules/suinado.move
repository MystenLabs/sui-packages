module 0xfbb9dcd6451c0904c9d60e71857b1926635d58bde8da5091754ef1d6c40a0e87::suinado {
    struct SUINADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINADO>(arg0, 6, b"Suinado", b"Suitornado", b"its a water tornado", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_1544470555_62aaefa30931_3f57b86ec4.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINADO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINADO>>(v1);
    }

    // decompiled from Move bytecode v6
}

