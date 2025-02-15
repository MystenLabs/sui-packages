module 0x986613c28000e5b6727a3a0abce2eba8589c6b5a0f6bac8fbf53acc7db66163::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"DEEP", b"Deep AI", b"Discover a world of creativity anew with hundreds of Al models on one platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U_U_U_U_U_U_U_U_U_U_U_U_U_U_ce6ebf8e92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

