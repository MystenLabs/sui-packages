module 0xf92d24d91e7d47dd88ebac97b76ac1bc204fd1c2a903049a906bb06ab4828b9a::gya {
    struct GYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYA>(arg0, 2, b"GYA", b"GYARADOS (https://twitter.com/GyaradosOnSui)", b"GYARADOS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1749417391618932736/L1_W7qMz_400x400.jpg")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GYA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GYA>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GYA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GYA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

