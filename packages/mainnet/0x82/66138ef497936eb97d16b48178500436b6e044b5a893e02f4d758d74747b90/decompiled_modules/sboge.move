module 0x8266138ef497936eb97d16b48178500436b6e044b5a893e02f4d758d74747b90::sboge {
    struct SBOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOGE>(arg0, 6, b"SBOGE", b"SUI BOGE", b"BOGE is a laid-back memecoin on the Sui network, featuring a chill dog mascot enjoying life with style. Built around fun and community, $BOGE aims to be the coolest token in the crypto space!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/boge_hp_1473x1536_d8026460e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

