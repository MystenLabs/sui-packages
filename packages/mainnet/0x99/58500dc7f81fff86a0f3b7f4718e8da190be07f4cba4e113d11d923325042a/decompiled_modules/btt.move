module 0x9958500dc7f81fff86a0f3b7f4718e8da190be07f4cba4e113d11d923325042a::btt {
    struct BTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTT>(arg0, 6, b"Btt", b"Bit-Tom", b"Bit-Tom the next generation of Bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003087_d95e01d5a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

