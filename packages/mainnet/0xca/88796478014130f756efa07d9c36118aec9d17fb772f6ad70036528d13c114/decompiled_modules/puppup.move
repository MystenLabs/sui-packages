module 0xca88796478014130f756efa07d9c36118aec9d17fb772f6ad70036528d13c114::puppup {
    struct PUPPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPUP>(arg0, 9, b"PUPPUP", b"Puppup", b"Such token. Much meme. Puppup dashes around wagging luck and barking up big surprises.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreihg4axoiacptiqisr4t647pqyvux4jkyf3xe5j5m644nzhivj6fnq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUPPUP>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPUP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

