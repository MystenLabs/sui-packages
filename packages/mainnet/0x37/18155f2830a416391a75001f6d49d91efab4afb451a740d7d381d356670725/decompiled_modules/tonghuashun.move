module 0x3718155f2830a416391a75001f6d49d91efab4afb451a740d7d381d356670725::tonghuashun {
    struct TONGHUASHUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONGHUASHUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONGHUASHUN>(arg0, 6, b"TongHuaShun", b"300033", b"TongHuaShun 300033", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_1_fd8bac2dfe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONGHUASHUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONGHUASHUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

