module 0xb6435e9cdf1cd2c89be3f6f4dfa5d20db936624c6889fdc335e4f77160642f5a::mdg {
    struct MDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDG>(arg0, 6, b"MDG", b"MOONDOG", b"the cosmic canine of meme season. Born to bark, built to moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreickla2d7llxrp44g3go7cv72qakyksmsnz7kbonc224i7yfusp2da")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MDG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

