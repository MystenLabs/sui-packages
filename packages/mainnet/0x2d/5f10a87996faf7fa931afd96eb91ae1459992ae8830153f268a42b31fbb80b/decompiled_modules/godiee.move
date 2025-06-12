module 0x2d5f10a87996faf7fa931afd96eb91ae1459992ae8830153f268a42b31fbb80b::godiee {
    struct GODIEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODIEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODIEE>(arg0, 6, b"GoDiee", b"IseeYouSniperBitchWallet", b"Btch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidwmcoq435vejelupxhx5nmjwfo53a6pok5qrgcqfn4ersa4vjafe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODIEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GODIEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

