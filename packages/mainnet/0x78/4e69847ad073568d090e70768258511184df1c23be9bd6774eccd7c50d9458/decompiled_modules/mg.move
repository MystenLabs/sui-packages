module 0x784e69847ad073568d090e70768258511184df1c23be9bd6774eccd7c50d9458::mg {
    struct MG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MG>(arg0, 6, b"MG", b"MG Coin", b"MG Coin from Squid Game 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0386_70cebb3f1e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MG>>(v1);
    }

    // decompiled from Move bytecode v6
}

