module 0xff7645a125d22168915243219202fee9f32d613e4c2eba95ca6ec202b9bf959a::utp {
    struct UTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UTP>(arg0, 6, b"UTP", b"UPTOMBER", b"Uptombder Pump (UTP) is the latest meme coin sensation thats taking the crypto world by storm. Its named after the fictitious month \"Uptombder,\" symbolizing a time when the markets pump to unprecedented highs for no reason at all! With an emblem featuring a rocket-powered tombstone soaring through the skies, Uptombder Pump embodies the humor and unpredictability of the crypto space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_digital_illustration_of_a_humorous_UPTOMBER_1_e2ef615be0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UTP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UTP>>(v1);
    }

    // decompiled from Move bytecode v6
}

