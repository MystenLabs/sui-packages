module 0xd627ad6be25353bd603f01a3258e4bc5b9591a83324e40261499c2a1689d2b98::mbc {
    struct MBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBC>(arg0, 9, b"MBC", b"Mutant Boys Club", b"Mutant Boys Club - $MBC, where the crypto community meets the next generation of meme culture!  Inspired by the iconic creations of Matt Furie, the Mutant Boys Club brings a fresh twist to the beloved characters, now debuting on the Solana blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/MBCccZZEbcvWzaHD9otPjmBMFaa6pG7XRYSw39HT5n2.png?size=xl&key=0218a1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MBC>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

