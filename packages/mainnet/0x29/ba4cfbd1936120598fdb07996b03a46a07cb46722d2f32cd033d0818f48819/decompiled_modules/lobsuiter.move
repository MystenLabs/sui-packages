module 0x29ba4cfbd1936120598fdb07996b03a46a07cb46722d2f32cd033d0818f48819::lobsuiter {
    struct LOBSUITER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOBSUITER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOBSUITER>(arg0, 6, b"LOBSUITER", b"GREAT LOBSTER OF SUI OCEAN", b"$LOBSUITER is a quirky token on Sui, bringing the lobsters tough, resilient nature into the crypto world. Whether clawing through the market or chilling on the ocean floor, $LOBSUITER is all about staying strong and moving forward. Grab your claws and join the Sui adventure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOBSUITER_b4b84ecf51.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOBSUITER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOBSUITER>>(v1);
    }

    // decompiled from Move bytecode v6
}

