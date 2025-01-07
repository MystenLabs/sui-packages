module 0x6ac3b6012ce49c66c90ddc1ed6f2e37b0a56e1d3b668c10e9b288aec85837eb2::popd {
    struct POPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPD>(arg0, 6, b"POPD", b"POPDENG", b"Bringing in the combination of two solana narrative of $POPCAT and $MOODENG into #SUI ecosystem, Ride with us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000118_6e30cdbdec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

