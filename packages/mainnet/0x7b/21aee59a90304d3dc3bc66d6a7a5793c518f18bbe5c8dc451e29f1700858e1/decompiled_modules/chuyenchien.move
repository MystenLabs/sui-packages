module 0x7b21aee59a90304d3dc3bc66d6a7a5793c518f18bbe5c8dc451e29f1700858e1::chuyenchien {
    struct CHUYENCHIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUYENCHIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUYENCHIEN>(arg0, 6, b"CHUYENCHIEN", b"MM CHUYENCHIEN", b"MEME GO TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thie_I_I_t_ke_I_I_chu_I_a_co_I_te_I_n_715a59a64c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUYENCHIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUYENCHIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

