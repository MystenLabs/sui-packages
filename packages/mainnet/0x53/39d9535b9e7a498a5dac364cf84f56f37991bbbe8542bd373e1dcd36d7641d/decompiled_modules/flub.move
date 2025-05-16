module 0x5339d9535b9e7a498a5dac364cf84f56f37991bbbe8542bd373e1dcd36d7641d::flub {
    struct FLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUB>(arg0, 6, b"FLUB", b"FLUB THE FISH", b"FLUB is a viral and audacious fish ( Blub little brother )", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic6uy4apo6gz7ulkvsl2ji4ipfdjeemivo6vstvduyydbntfmjr7i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

