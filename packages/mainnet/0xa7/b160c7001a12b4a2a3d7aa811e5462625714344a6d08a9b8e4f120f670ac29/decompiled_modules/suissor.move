module 0xa7b160c7001a12b4a2a3d7aa811e5462625714344a6d08a9b8e4f120f670ac29::suissor {
    struct SUISSOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISSOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISSOR>(arg0, 6, b"SUISSOR", b"Suissor", b"Dont Get Cut! Dont Get Cut!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_21_25_39_a8b4f87dba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISSOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISSOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

