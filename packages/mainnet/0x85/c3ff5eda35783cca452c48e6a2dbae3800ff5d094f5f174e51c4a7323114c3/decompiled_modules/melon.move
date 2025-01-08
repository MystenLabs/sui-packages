module 0x85c3ff5eda35783cca452c48e6a2dbae3800ff5d094f5f174e51c4a7323114c3::melon {
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

