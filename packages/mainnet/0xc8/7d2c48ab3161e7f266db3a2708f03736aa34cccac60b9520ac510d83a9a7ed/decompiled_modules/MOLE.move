module 0xc87d2c48ab3161e7f266db3a2708f03736aa34cccac60b9520ac510d83a9a7ed::MOLE {
    struct MOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLE>(arg0, 6, b"TrenchMole", b"MOLE", b"A meme coin for the relentless warriors of the underground. TrenchMole celebrates the gritty, never-give-up spirit of mole fighters in the trenches. Dig deep, fight hard, and hodl like a mole!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafybeib7uc32fldwr3kk63aznazwcos73fhicfjti5aksrxga3ncnuqbcq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLE>>(v0, @0xa51c5054322c872e7b8545d2a271548f8a3630a73247361eea063e7953e727a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

