module 0x3a4cd6e9334b06567b681121a7cd9df8d665108de012c7681bbbd19560325b24::pugpop {
    struct PUGPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGPOP>(arg0, 6, b"PUGPOP", b"Pop The Pug", b"PUGPOP is a digital pug born on SUI. He exists to bring back what is been missing real internet culture with soul.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7lv3omz4k32xf4ucoiqoqweju7tkuxqqjwr3x7w3vb6jld46bqq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGPOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUGPOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

