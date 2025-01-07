module 0x1d3fe6aa2bd6f0b90dd83e289b609b9374fdb197543efedfc9d0c28e6481d335::kjp {
    struct KJP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KJP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KJP>(arg0, 6, b"KJP", b"Kim Jong Pepe", b"Kim Jong Pepe on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_03_14_23_21_28_9f76af3ae1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KJP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KJP>>(v1);
    }

    // decompiled from Move bytecode v6
}

