module 0xdc29f089401d4cc9db9976c2bbec4a7b7f704a0a4ff33274709c8e2293e86853::dbook {
    struct DBOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBOOK>(arg0, 6, b"DBOOK", b"DeepBook", b"Gm to those who still gm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_1_f4fd2c1018.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

