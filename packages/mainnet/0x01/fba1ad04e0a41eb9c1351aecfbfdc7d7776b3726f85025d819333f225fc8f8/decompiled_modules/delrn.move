module 0x1fba1ad04e0a41eb9c1351aecfbfdc7d7776b3726f85025d819333f225fc8f8::delrn {
    struct DELRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELRN>(arg0, 6, b"DELRN", b"DELOREAN", b"Time travel meets onchain tech. DeLorean just dropped the first ever vehicle reservation system and marketplace on SuiNetwork featuring none other than SirPatStew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibt7kk7zkc2bsdmxtzisxt3pujyng4tfr7t3y57lrqz6ufkcpogu4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DELRN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

