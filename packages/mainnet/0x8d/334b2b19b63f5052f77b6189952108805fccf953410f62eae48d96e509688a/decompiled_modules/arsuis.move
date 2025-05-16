module 0x8d334b2b19b63f5052f77b6189952108805fccf953410f62eae48d96e509688a::arsuis {
    struct ARSUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARSUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARSUIS>(arg0, 6, b"ARSUIS", b"ARSUIS THE MYTHICAL", b"$ARSUIS -Inspired by Arceus The Mythical Pokemon. The known creator of Pokemon world and the most powerful of all Pokemons and here to dominate in $SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaeyy42ulxuqnivlhy4jcsnyydjijvnntivkrjwuuanw5pyjoe5dq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARSUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARSUIS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

