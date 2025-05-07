module 0xd9405a5775facf38beb160f9e072c4127bbf8521d26091ac330beadeaef524dc::crycatto {
    struct CRYCATTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYCATTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYCATTO>(arg0, 6, b"CRYCATTO", b"Crypto Catto", b"A cat who is into crypto, the crypto catto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebq3wlq7kjoknnuxaxghz3nfw7psa2xbjzobojxlbvhz5ylsnx3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYCATTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRYCATTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

