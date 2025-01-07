module 0x4742107c36344cb84ffdb88aa7cc59ca1a6128cc96cd7aaa54210a893da62fbe::naloong {
    struct NALOONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NALOONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALOONG>(arg0, 6, b"NALOONG", b"Naloong", b"Nallong and sui to make frens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/naloong_f2557d6172.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALOONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NALOONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

