module 0x31facd24f13cda7e6bba2e37beee32a18246ab2192e07193eb66a60a588bd292::suimeme {
    struct SUIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEME>(arg0, 9, b"SUIMEME", b"Sui Meme", b"SUI MEME IS MEME ON SUI CHAIN,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://purple-neat-mole-319.mypinata.cloud/ipfs/QmU2EXvt93JnFqaEesztAtagA1vCZT4uaUTuGb39XCEB5N")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMEME>(&mut v2, 666000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

