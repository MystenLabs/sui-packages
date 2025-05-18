module 0x3cc20fd1d5b1e656d8aed62d3d75a7b368b3258f8db1590bd50ef10196743d5::tesd {
    struct TESD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESD>(arg0, 6, b"TESD", b"test", b"cs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreichibwkkg6tdctokni6ms7dpkk6nl3nkqdxebtjksi6hrtjsueufe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

