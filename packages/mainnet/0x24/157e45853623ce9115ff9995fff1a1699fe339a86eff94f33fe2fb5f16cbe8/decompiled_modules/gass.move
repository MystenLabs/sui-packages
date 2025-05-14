module 0x24157e45853623ce9115ff9995fff1a1699fe339a86eff94f33fe2fb5f16cbe8::gass {
    struct GASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GASS>(arg0, 6, b"GASS", b"Gasspas", b"Gasspas the cat, nemesis of Rato and the newest Matt Furie character. $GASS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaaf3e53vhogmmkhg4lueb4cscqf5xgp5vk7zak7ik6zfdjy73uc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GASS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

