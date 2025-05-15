module 0xd338e24e83d5bd01052945af6af0cf403a7994ecdc2cbd835051ddfb07e4d2e6::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKET>(arg0, 6, b"ROCKET", b"TEAM ROCKET", b"Team $ROCKET Forged on the $SUI Network. Meme magic meets real-world matter. Print the legend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreift5xopo4fnzbi5pzpb746hyhhrtbi3bdcsgrqdq2e7s4oiaap3qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROCKET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

