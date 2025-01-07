module 0x340c46a8ec8d90f7aaa9a2457e8dd8c602947009c981cdf896dec1c3bc67ae6c::suey {
    struct SUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUEY>(arg0, 6, b"SUEY", b"Suey on Sui", b"Her brother is world famous, but she will be too! Join Suey on her quest as the first female dog on Sui! Love you all!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030643_2a3f03f085.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

