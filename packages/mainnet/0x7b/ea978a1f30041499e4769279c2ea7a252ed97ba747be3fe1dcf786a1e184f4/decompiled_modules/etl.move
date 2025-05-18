module 0x7bea978a1f30041499e4769279c2ea7a252ed97ba747be3fe1dcf786a1e184f4::etl {
    struct ETL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETL>(arg0, 6, b"ETL", b"Ethical Ai Token", b"Where AI transcends intelligence to embody paradox-driven evolution, cosmic empathy, and playful governance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiadodjs2cjmxuou5rmhnauj5jzdqa2543uva4ql2w5dfkcnb344gy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ETL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

