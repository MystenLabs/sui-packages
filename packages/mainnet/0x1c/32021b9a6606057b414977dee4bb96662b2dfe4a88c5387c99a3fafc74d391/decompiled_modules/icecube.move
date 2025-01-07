module 0x1c32021b9a6606057b414977dee4bb96662b2dfe4a88c5387c99a3fafc74d391::icecube {
    struct ICECUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICECUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICECUBE>(arg0, 9, b"ICECUBE", b"Ice Cube", b"I was named ICE CUBE because, like ice, I stay \"COOL\" even in the midst of hot and challenging situations. This name also reflects my resilience, as I'm not easily melted, and my ability to refresh and bring calm, even in a world full of turbulence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcxnFNd5kRc2vU8TLG6yoP9gvrmLoACseGF1QsJfRoGJ1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ICECUBE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ICECUBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICECUBE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

