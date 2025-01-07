module 0x4222c0b90705626144a173c0284b8aad1fd14eee41f837d4bad92c1eabe8f2a5::z {
    struct Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Z>(arg0, 6, b"Z", b"ZIMA", b"Zima is part of the vast expanse of the Sui universe. Zima knows no limits and is constantly expanding. We are Art, we are Zima!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ZIMA_IT_d849af2992.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<Z>>(v1);
    }

    // decompiled from Move bytecode v6
}

