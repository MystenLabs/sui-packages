module 0x1bc422d6da465e6409aeeb9066d02384533fb55dd143dac32a2613333fa8a7c2::feels {
    struct FEELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEELS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEELS>(arg0, 6, b"FEELS", b"Strategic $FEELS Reserve", x"436f6d6d756e697479206c61756e6368696e67202253747261746567696320244645454c532052657365727665220a5472756d70202b20576f6a616b203d20486f7069756d20626162790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FEELS_MEME_COIN_03_097278aa16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEELS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEELS>>(v1);
    }

    // decompiled from Move bytecode v6
}

