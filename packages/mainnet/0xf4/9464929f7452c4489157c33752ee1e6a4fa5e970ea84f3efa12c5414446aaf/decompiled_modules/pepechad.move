module 0xf49464929f7452c4489157c33752ee1e6a4fa5e970ea84f3efa12c5414446aaf::pepechad {
    struct PEPECHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECHAD>(arg0, 9, b"PEPECHAD", b"Pepe the Chad", b"Pepe the Chad is back! More powerful and pumped up, ready to dominate the crypto scene. The ultimate alpha meme evolution has landed prepare for the flex! #CHADTAKEOVER WE ARE LOOKING FOR REAL CHADS ONLY, TO BUILD FOUNDATION, JEETS STAY AWAY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F7_289c334bb6.png&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPECHAD>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECHAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

