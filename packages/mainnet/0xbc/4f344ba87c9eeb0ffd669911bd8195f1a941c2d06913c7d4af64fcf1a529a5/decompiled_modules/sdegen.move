module 0xbc4f344ba87c9eeb0ffd669911bd8195f1a941c2d06913c7d4af64fcf1a529a5::sdegen {
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

