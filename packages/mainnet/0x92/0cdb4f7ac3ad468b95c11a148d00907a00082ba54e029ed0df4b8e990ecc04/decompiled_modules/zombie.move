module 0x920cdb4f7ac3ad468b95c11a148d00907a00082ba54e029ed0df4b8e990ecc04::zombie {
    struct ZOMBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMBIE>(arg0, 6, b"Zombie", b"SuiZombie", b"SUI ZOMBIE is not just a game. Its a virtual world where every weapon, gear, and shelter you find is a digital asset secured on the Sui Blockchain, launching live on MoonBags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic4vq2dsife6tcgmuvsu55mthojnxy5dsulq2wqqqgoavjt4imadq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMBIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZOMBIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

