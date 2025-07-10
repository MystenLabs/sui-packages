module 0xcbb2f3893efae35de794e75ce44e4a9767f295d2d7c666ac43a312d8f37a5efe::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 9, b"DEGEN", b"DEGENS OF BONK", b"Made by degens for degens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmZVLDVPgT3rHiSqQ61R5HdtjjhBDVkKfFUpWUHWvKqPyZ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEGEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

