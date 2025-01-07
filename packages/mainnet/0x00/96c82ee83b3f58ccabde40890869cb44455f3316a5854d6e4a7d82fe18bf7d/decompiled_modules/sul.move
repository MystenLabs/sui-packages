module 0x96c82ee83b3f58ccabde40890869cb44455f3316a5854d6e4a7d82fe18bf7d::sul {
    struct SUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUL>(arg0, 6, b"SUL", b"Sui lion", b"Join the pride with $SUiLION, the meme token that roars in support of the Sui community! Backed by the legendary energy of the Lion, SUiLION is here to take the crypto jungle by storm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000401257_f48943d8d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

