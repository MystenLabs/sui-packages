module 0x4e6cd43af6c1f28fa094e6a9bdab5d44418769afb269366501144107a6d91538::dead {
    struct DEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAD>(arg0, 6, b"DEAD", b"Buy if yo momma dead", b"testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiausiabi6ej4ftvikttwijpjk4p5uyikm2dinhnh3dbemhgcjxuim")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

