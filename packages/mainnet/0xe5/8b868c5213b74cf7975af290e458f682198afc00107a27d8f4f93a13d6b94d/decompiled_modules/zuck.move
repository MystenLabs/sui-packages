module 0xe58b868c5213b74cf7975af290e458f682198afc00107a27d8f4f93a13d6b94d::zuck {
    struct ZUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUCK>(arg0, 6, b"Zuck", b"PROPOSEUR ATROCE", b"Dig sa mere.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GPUGNGEEJZGIBH_2_XZISENLBOUY_1bbf82a7ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

