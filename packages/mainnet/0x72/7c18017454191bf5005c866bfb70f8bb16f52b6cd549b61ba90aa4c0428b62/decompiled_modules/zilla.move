module 0x727c18017454191bf5005c866bfb70f8bb16f52b6cd549b61ba90aa4c0428b62::zilla {
    struct ZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZILLA>(arg0, 6, b"ZILLA", b"Suizilla", b"Sui and Gozilla are two monsters from different places, who have now joined forces and will roar throughout the ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibb3nyapcqn3kt4sp2yff2bpdxzxlmsqealbhvtelb2vnr6ayj3pa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZILLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

