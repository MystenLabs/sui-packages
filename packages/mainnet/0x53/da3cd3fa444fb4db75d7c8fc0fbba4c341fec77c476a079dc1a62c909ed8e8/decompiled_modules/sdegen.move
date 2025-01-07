module 0x53da3cd3fa444fb4db75d7c8fc0fbba4c341fec77c476a079dc1a62c909ed8e8::sdegen {
    struct SDEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDEGEN>(arg0, 6, b"SDEGEN", b"Sui Degen", b"DEGEN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728393480999_a3626f7a19.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDEGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

