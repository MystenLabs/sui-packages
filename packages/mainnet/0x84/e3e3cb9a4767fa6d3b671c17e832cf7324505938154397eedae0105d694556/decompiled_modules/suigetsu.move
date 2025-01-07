module 0x84e3e3cb9a4767fa6d3b671c17e832cf7324505938154397eedae0105d694556::suigetsu {
    struct SUIGETSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGETSU>(arg0, 6, b"SUIGETSU", b"Suigetsu", b"$SUIGETSU, an anime token on SUI blockchain. SUI means water in Chinese and Suigetsu is a water based justu user from the Naruto anime. He's also from the Hidden Village in the Mist. SUI blockchain is founded by Mysten Labs. Coincidence? I think not!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mola_f725c8c7bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGETSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGETSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

