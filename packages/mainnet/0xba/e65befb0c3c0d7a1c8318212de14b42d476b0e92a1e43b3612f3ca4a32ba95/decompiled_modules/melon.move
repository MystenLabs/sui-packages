module 0xbae65befb0c3c0d7a1c8318212de14b42d476b0e92a1e43b3612f3ca4a32ba95::melon {
    struct MELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELON>(arg0, 6, b"MELON", b"Melondog", b"Its literally just a dog with a melon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_xqx_Jj_P_400x400_a0aa5159e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

