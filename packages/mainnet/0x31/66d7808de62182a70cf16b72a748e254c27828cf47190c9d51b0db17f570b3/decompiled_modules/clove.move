module 0x3166d7808de62182a70cf16b72a748e254c27828cf47190c9d51b0db17f570b3::clove {
    struct CLOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOVE>(arg0, 6, b"CLOVE", b"Sui clove", b"CLOVE The kune kune pig on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008787_a5d27dac2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

