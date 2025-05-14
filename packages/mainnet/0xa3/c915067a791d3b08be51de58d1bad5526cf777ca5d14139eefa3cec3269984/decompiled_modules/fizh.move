module 0xa3c915067a791d3b08be51de58d1bad5526cf777ca5d14139eefa3cec3269984::fizh {
    struct FIZH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIZH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIZH>(arg0, 6, b"Fizh", b"King Fizh", b"Life is More Funny at Sea  | 2,1K NFTs  | $KING Conquering the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidtldie6upidhnlceo5hx6o5yav6mbdp4ajhyhv23wzgzln2iqd4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIZH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIZH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

