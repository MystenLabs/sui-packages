module 0x3ead7f91619ccad1761f87f33f840fcdc2e33c30a357b8402ef56e115af62ade::mblub {
    struct MBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBLUB>(arg0, 6, b"MBLUB", b"Mutant Blub", b"MutantBlub, the DEGEN version of Blub! RELAUNCH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihgy4zyrfvhx67jgq26oqpqvunpwn4e63wbqmsswkx766go5fxlbm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBLUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

