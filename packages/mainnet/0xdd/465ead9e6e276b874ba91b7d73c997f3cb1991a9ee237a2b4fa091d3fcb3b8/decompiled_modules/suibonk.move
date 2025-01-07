module 0xdd465ead9e6e276b874ba91b7d73c997f3cb1991a9ee237a2b4fa091d3fcb3b8::suibonk {
    struct SUIBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBONK>(arg0, 9, b"SUIBONK", b"Sui Bonk", b"Bonk !!!! Meme token from solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmSoTSzFWTowoqMaBu1mQ6RPP1Mqv5CF9mT6Bp7RmwmB7q")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBONK>(&mut v2, 666000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

