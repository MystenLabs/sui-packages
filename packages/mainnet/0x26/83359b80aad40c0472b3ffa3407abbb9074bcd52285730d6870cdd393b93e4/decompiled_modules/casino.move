module 0x2683359b80aad40c0472b3ffa3407abbb9074bcd52285730d6870cdd393b93e4::casino {
    struct CASINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASINO>(arg0, 6, b"CASINO", b"the greatest casino", b"SUI is the worlds greatest casino", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ih_33_H_Ff_f4f9c5c9a8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

