module 0x318307efb41e70922b69a92d7b32fee350cae7fe0a3ddb1575fae6cf4ff16140::moji {
    struct MOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJI>(arg0, 6, b"MOJI", b"Moogiraffe", b"10000000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_N_D_N_6bbe9c32e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

