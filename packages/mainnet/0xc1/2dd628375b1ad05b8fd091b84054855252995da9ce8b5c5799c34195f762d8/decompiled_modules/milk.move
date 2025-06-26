module 0xc12dd628375b1ad05b8fd091b84054855252995da9ce8b5c5799c34195f762d8::milk {
    struct MILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILK>(arg0, 6, b"MILK", b"Milk tee", b"Caution: jft dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidmesfwqlo5cv6iizdh5kvf5tpv4b3li2t5u25e3wcnbnw7cognp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MILK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

