module 0xcdb0539565b837afee9d01f2a28fdd2bd7c9a5c773564add244fdd66811d07f1::neir {
    struct NEIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIR>(arg0, 6, b"Neir", b"Neira", b"Neira is a token created specifically for those who love to have fun and aren't afraid to play around a bit in the world of cryptocurrency. It is built on the SUI blockchain, which means fast transactions, low fees, and complete security for your funds. But most importantly, Neira brings a little humor and positivity into this world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_17_11_05_55_7d42cc9417.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

