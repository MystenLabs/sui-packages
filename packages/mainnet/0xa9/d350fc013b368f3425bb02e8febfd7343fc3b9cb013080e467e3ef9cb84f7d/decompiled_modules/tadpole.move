module 0xa9d350fc013b368f3425bb02e8febfd7343fc3b9cb013080e467e3ef9cb84f7d::tadpole {
    struct TADPOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TADPOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TADPOLE>(arg0, 9, b"Tadpole", b"TAD", b"TAD is the iconic offspring of Base. With the mission to become the official amphibian mascot of the chain, bringing the best Community Onchain forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TADPOLE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TADPOLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TADPOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

