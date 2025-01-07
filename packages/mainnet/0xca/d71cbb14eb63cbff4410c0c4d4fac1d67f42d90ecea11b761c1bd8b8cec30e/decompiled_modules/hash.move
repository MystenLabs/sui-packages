module 0xcad71cbb14eb63cbff4410c0c4d4fac1d67f42d90ecea11b761c1bd8b8cec30e::hash {
    struct HASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASH>(arg0, 6, b"HASH", b"Hash on Sui", b"https://t.me/addstickers/HashOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029396_d3864f187a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

