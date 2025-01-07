module 0x7b475e9b582583b6307a4fe612524b783b2c854b466a5331a4a8d944a8600801::derekjeeter {
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

