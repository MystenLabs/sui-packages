module 0x65c507e617ae1cc47f2c497f4a2b3ce56aebe2ad51c038a26c8e8a8e046a110e::dopamine {
    struct DOPAMINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPAMINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPAMINE>(arg0, 6, b"DOPAMINE", b"GEN Z Currency", b"GEN Z Currency : DOPAMINE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihg2ssf6pllxrnatcv7mlhe2xylslcxyoxr5uyjsnaemr25zcac6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPAMINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOPAMINE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

