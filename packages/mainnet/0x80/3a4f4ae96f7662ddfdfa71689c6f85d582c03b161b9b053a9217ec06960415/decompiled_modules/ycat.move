module 0x803a4f4ae96f7662ddfdfa71689c6f85d582c03b161b9b053a9217ec06960415::ycat {
    struct YCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YCAT>(arg0, 6, b"YCAT", b"Yellow Cat", b"Just a yellow Cat on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/anh_meo_cute_hoat_hinh_1_01_14_33_07_87613c7128.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

