module 0x290a5635c219f9134cd865cff2b49cfefb05ef3695d4baaf8070ea15b0948f2f::skel {
    struct SKEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKEL>(arg0, 6, b"SKEL", b"SKELETON", b"The Undead Pulse of the SUI Blockchain. Whether you're staking your claim in the crypt or trading in the underworld, SKEL thrives where others rot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihzjw34evwang55ekeekl22nbt4eram2r6pstl7rlirzcruazll4a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

