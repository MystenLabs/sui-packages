module 0xcfa3cfd11b2c05f2d1e4009871c5d1cd4b1a816a80598fd573a553874e769453::derekjeeter {
    struct DEREKJEETER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEREKJEETER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEREKJEETER>(arg0, 6, b"DerekJeeter", b"Derek Jeeter", b"The coolest Jeeter in crypto.  I'm the Jeeter that wins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/derekjeetertwitter_941b049700.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEREKJEETER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEREKJEETER>>(v1);
    }

    // decompiled from Move bytecode v6
}

