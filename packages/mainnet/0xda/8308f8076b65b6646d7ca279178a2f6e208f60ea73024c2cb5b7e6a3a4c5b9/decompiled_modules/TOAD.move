module 0xda8308f8076b65b6646d7ca279178a2f6e208f60ea73024c2cb5b7e6a3a4c5b9::TOAD {
    struct TOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOAD>(arg0, 6, b"Toad King", b"TOAD", b"A ribbiting meme coin that leaps into your wallet with fun and profits! Inspired by the mighty toad, this coin is all about community, memes, and hopping to the moon. Join the TOAD army and let's croak our way to success!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafybeifi3fzjkv6qyyv2nmnftqynxxim5kxyrjezppuar3nyd2dukl73rm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOAD>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

