module 0xc59ee36daaed58baf5d45af2221227009e8b6727a9d314b5dac9ccada803cc49::flo {
    struct FLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLO>(arg0, 6, b"Flo", b"Flo the Happy Faucet", b"Flo the Faucet is your favorite plumbing pal, always ready to deliver a steady flow of laughs and good vibes! With a cheerful face and a playful spirit, Flo represents the fun side of lifes little moments. Whether your'e just hanging out or getting into mischief, Flo the Faucet is here to keep the good times flowing one hilarious drop at a time! Join the fun and let Flo brighten your day with a splash of humor!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/faucet_good_versio_a927268329.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

