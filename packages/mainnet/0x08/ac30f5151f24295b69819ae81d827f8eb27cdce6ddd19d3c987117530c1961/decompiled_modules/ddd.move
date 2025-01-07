module 0x8ac30f5151f24295b69819ae81d827f8eb27cdce6ddd19d3c987117530c1961::ddd {
    struct DDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDD>(arg0, 6, b"Ddd", b"rrr", b"d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9271_9aa2f53e4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

