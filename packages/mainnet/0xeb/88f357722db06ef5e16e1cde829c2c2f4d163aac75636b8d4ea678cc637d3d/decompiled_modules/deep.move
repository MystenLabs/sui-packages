module 0xeb88f357722db06ef5e16e1cde829c2c2f4d163aac75636b8d4ea678cc637d3d::deep {
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

