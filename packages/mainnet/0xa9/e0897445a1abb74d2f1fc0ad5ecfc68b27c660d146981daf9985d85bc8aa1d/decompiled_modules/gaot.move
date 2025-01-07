module 0xa9e0897445a1abb74d2f1fc0ad5ecfc68b27c660d146981daf9985d85bc8aa1d::gaot {
    struct GAOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAOT>(arg0, 6, b"GAOT", b"GOAT token", b"Animal is better than AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1161728832013_pic_688aaadb4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

