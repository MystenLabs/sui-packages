module 0xa554c11f5f7a0f2de227a0a4c2e6d926a27f922427497423d185cfb381aae715::capo {
    struct CAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPO>(arg0, 6, b"CAPO", b"Cap Otter", b"Women want me , Fish fear me ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9a5bf984bce7da500498c488b4cfec2b_dce18b7fb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

