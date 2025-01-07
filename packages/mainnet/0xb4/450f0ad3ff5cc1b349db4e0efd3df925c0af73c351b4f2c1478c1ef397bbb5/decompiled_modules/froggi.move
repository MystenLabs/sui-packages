module 0xb4450f0ad3ff5cc1b349db4e0efd3df925c0af73c351b4f2c1478c1ef397bbb5::froggi {
    struct FROGGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGI>(arg0, 9, b"FROGGI", b"Froggi", b"$Froggi is a unique, fully on-chain PFP project offering users the ability to reroll their token(s). Each portion of tokens resembles a seed that generates unique dynamic images stored on-chain, depending on the wallet's token balance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x88a78c5035bdc8c9a8bb5c029e6cfcdd14b822fe.png?size=xl&key=339d15")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FROGGI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

