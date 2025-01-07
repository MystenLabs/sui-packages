module 0x6698cd0d3466115f59bd703d9f250721f1094f4a0863073b47b7fae6b185c311::billy {
    struct BILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLY>(arg0, 6, b"BILLY", b"BILLION DOLLAR CAT", b"BILLY to billies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wv_A945q_L_400x400_1f3c23418b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

