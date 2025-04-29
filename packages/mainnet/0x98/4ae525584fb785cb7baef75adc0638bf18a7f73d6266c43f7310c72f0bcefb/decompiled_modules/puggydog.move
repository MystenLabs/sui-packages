module 0x984ae525584fb785cb7baef75adc0638bf18a7f73d6266c43f7310c72f0bcefb::puggydog {
    struct PUGGYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGGYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGYDOG>(arg0, 6, b"PuggyDog", b"PuggyDogSUI", x"5055474759444f4720697320746865206d6f737420636f6f6c65737420616e64206472697070696e272064617767206f6e0a537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif2i5st6zluvk3kwjeiayt5rponwgqxtu7tse44osjth5oolmg4qm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUGGYDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

