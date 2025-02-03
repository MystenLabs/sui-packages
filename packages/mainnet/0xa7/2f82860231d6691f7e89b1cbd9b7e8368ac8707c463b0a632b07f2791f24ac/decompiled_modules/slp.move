module 0xa72f82860231d6691f7e89b1cbd9b7e8368ac8707c463b0a632b07f2791f24ac::slp {
    struct SLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLP>(arg0, 6, b"SLP", b"SleppyPup", b"Introducing sleepyPup coin($SLP) - the cryptocurrency that captures the heartwarming charm of a sleeping puppy. $SLP Combines the playful spirit of internet cult", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032638_d24177aff7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

