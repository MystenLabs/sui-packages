module 0xe60110976596bdeeb38da815d896c1dac26c69aad1288ef3be83e5f6abed5cf9::blorb {
    struct BLORB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLORB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLORB>(arg0, 9, b"BLORB", b"Blorb", b"Amorphous wisdom: The rounder, the better the bounce.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihbc2txhrctn3o6mdwy4q7fylrypctosecnek7jakocdj2teagesi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLORB>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLORB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLORB>>(v1);
    }

    // decompiled from Move bytecode v6
}

