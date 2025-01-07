module 0x447e2eecd751a05454281cadcaceb8e9c33688598f3173d3fdfce819bbcca5ac::hopmoon {
    struct HOPMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPMOON>(arg0, 6, b"HopMoon", b"Hop Moon", b"Hop to the moon with $HopMoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_humorously_illustrated_meme_coin_featuring_3_bcb9928e73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

