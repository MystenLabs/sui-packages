module 0x52858c3dd35e4936e222f68f8c0c408c1643db40f497ce5f863985341a9d41a2::catesui {
    struct CATESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATESUI>(arg0, 6, b"CATESUI", b"SUICATE", b"CATE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/catesuilogo_31f4843567.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

