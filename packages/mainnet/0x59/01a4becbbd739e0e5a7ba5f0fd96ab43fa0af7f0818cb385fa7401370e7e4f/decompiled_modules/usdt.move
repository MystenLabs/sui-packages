module 0x5901a4becbbd739e0e5a7ba5f0fd96ab43fa0af7f0818cb385fa7401370e7e4f::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT", b"jhj", b"dsa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_51e7c2cc68.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

