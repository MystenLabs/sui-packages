module 0x4b898c1225de98123ce10c55b618094e6c3f492ac724d7d2e0a4ea4d35fe4cbc::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER", b"its 2 Atom Hydrogren and binding on Oxygen", b"Just a scientist who love 2 Atom Hydrogren who binding on Oxygen, well its water tho", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_OD_Wk_Bu_400x400_ee46d0e4c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

