module 0x493eb6c31664b64a8ea23e378fac427942264c25febc83692ec09b9b4c80c324::a8mcoin {
    struct A8MCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: A8MCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A8MCOIN>(arg0, 6, b"A8MCOIN", b"A8M Coin", b"The official and only coin of Articulate Madness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A8_M_Coin_250x250_6ff2bf7b4f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A8MCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A8MCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

