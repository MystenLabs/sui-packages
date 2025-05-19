module 0xe92ba47ee77afda391b6a4eff7ea1547385c4b987d6e6098b2754b0dcde9e076::puppup {
    struct PUPPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPUP>(arg0, 9, b"PUPPUP", b"Puppup", b"Such token. Much meme. Puppup dashes around wagging luck and barking up big surprises.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreihg4axoiacptiqisr4t647pqyvux4jkyf3xe5j5m644nzhivj6fnq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUPPUP>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPUP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUPPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

