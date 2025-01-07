module 0x1d79d5c6cf852a86dd60ad2703a4bf7aec0ff4da66b35a08bf4f4636942c237f::tsla {
    struct TSLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSLA>(arg0, 6, b"TSLA", b"TESLA6900", b"TSLA - This has nothing to do with TESLA! Its a parody account.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kovxa_Y_Uv_400x400_2895fb0a14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

