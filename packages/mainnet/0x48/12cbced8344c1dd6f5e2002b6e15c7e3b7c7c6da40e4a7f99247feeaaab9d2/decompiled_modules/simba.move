module 0x4812cbced8344c1dd6f5e2002b6e15c7e3b7c7c6da40e4a7f99247feeaaab9d2::simba {
    struct SIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMBA>(arg0, 6, b"SIMBA", b"SimbaOnSui", b"Community token on SUI. simbaonsui.vip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pg0r_BM_7e_400x400_cd7d91b2d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

