module 0x599d88ca53702426e6d7a62ae7b3ea55384206def6ed7f44d5d9ef27ad18e80a::smbc {
    struct SMBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMBC>(arg0, 9, b"SMBC", b"Sui Mutant Boys Club", b"next nft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/MBCccZZEbcvWzaHD9otPjmBMFaa6pG7XRYSw39HT5n2.png?size=lg&key=0218a1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMBC>(&mut v2, 500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMBC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

