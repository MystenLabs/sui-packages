module 0xed8b26c3cfe00c57b156c5f13b81f33702ac5d567c5990289043c292007a93da::buddy {
    struct BUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDDY>(arg0, 6, b"BUDDY", b"SUI BUDDY", b"Buddy On SUI Your guide dog on the SUI chain, $BUDDY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_1_517dfe964b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

