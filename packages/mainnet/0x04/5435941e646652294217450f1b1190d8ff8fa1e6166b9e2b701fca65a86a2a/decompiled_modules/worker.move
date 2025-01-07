module 0x45435941e646652294217450f1b1190d8ff8fa1e6166b9e2b701fca65a86a2a::worker {
    struct WORKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORKER>(arg0, 6, b"WORKER", b"Worker", b"Worker of Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ce8e4a16_6296_4e7d_a5c7_169ca86265ab_1_all_8060_ab2324339b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

