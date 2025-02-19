module 0xe264fc8d561b61b2394079d7020150eb9dcc8a2a567929128c015ba12e31ebcf::jailx {
    struct JAILX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAILX>(arg0, 9, b"JAILX", b"JailX", b"JailX is a decentralized AI challenge platform where creators design AI agents with unique puzzles, and challengers attempt to break them. Outsmart AI restrictions, solve hidden missions, and earn rewards for successful jailbreaks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmR7VZQY1NMK1vtQmEZseopTvbfe6KMX6SvLZoakP62gpd")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JAILX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAILX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

