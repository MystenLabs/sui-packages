module 0xfc1f47fc92ba9f3b5bad054823a26fe56a5c54748707e082aea91ce0bbb0e0a::kishu {
    struct KISHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KISHU>(arg0, 6, b"KISHU", b"Kishu Inu on SUI", b"Meet Kishu Inu & its guardian angel.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Yzw_Y_Ze_Dh_400x400_958085bc96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KISHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

