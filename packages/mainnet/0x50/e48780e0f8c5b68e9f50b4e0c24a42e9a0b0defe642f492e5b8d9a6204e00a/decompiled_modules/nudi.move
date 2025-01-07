module 0x50e48780e0f8c5b68e9f50b4e0c24a42e9a0b0defe642f492e5b8d9a6204e00a::nudi {
    struct NUDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUDI>(arg0, 6, b"NUDI", b"Nudibranch", b"NUDI the Sea Rabbit is here for a show", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a6ad6484_2d15_4018_9abf_4182945e6850_5445281ed6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

