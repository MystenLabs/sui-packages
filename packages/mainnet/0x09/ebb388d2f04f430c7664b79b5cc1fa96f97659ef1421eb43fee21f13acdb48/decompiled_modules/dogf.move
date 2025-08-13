module 0x9ebb388d2f04f430c7664b79b5cc1fa96f97659ef1421eb43fee21f13acdb48::dogf {
    struct DOGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGF>(arg0, 6, b"DogF", b"DogTokenF", b"Dontbuy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

