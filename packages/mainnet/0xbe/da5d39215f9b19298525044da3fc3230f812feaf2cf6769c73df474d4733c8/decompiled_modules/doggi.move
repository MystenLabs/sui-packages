module 0xbeda5d39215f9b19298525044da3fc3230f812feaf2cf6769c73df474d4733c8::doggi {
    struct DOGGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGI>(arg0, 6, b"DOGGI", b"DOGGI Coin", b"DOGGI Meme buy if you want", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGGI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

