module 0xa8ce60bbed72339522407455c94b295b087c14471d8985bf4051577efad6d0f6::musky {
    struct MUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSKY>(arg0, 6, b"MUSKY", b"DONKEY MUSKY", b"Hi, my name is MUSKY the sui-donkey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiealkdj6dka7kq4wbaqatx4foprrnalfii3iu3ajfimcu4dclffgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUSKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

