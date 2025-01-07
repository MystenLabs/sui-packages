module 0xfd0e764ce59e05394bfa192f946d17a93735e9586af44c01feb58a7a0b27826::spongebob {
    struct SPONGEBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGEBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGEBOB>(arg0, 6, b"SPONGEBOB", b"Spongebob On Sui", x"2249276d207265616479212049276d2072656164792122202d53706f6e6765626f622d0a53756920436861696e20697320676f6f642c2053706f6e6765626f622073697474696e6720686572652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_13_48_12_dc236964bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGEBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGEBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

