module 0xcf1d1b2ba29f131e94f2bfc0a19430fd4b65b1d2911d3d495eb18a76d82fa819::panther {
    struct PANTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANTHER>(arg0, 9, b"Panther", b"Pink Panther", b"Meme-icking on Solana, one paw at a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZStXNmEeXy637vgYtszC9f8R2bFEZ3McsKi3h6Hmy7ij")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PANTHER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANTHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANTHER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

