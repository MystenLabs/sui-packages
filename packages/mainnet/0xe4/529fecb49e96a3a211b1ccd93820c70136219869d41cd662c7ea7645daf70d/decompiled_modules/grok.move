module 0xe4529fecb49e96a3a211b1ccd93820c70136219869d41cd662c7ea7645daf70d::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 9, b"GROK", b"BOME GROK", b"Welcome to BOME GROK, the next frontier in the evolution of Web3 culture. This experimental initiative merges the influence of memes with decentralized storage and the high-stakes world of degen shitcoin trading and gambling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmXk3bYwuqawTdBMtCyCqmMaTwapQvskT8z8VnirY3wuAC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GROK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

