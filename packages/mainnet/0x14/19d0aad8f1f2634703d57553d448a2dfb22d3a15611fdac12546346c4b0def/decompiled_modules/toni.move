module 0x1419d0aad8f1f2634703d57553d448a2dfb22d3a15611fdac12546346c4b0def::toni {
    struct TONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONI>(arg0, 6, b"TONI", b"TonionSui", b"the baby pygmy hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ljf_N3_Nc_S_400x400_342a63a029.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

