module 0xfbb23ab6438e0d2992197634c43a806163733c303d57dc86ac6fd50bf3ab8f8f::badpole {
    struct BADPOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADPOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADPOLE>(arg0, 9, b"Badpole", b"BAD", b"BAD is the iconic offspring of Base. With the mission to become the official amphibian mascot of the chain, bringing the best Community Onchain forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BADPOLE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADPOLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADPOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

