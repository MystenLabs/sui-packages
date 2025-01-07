module 0xc3deefdb497fed81bd67656bd8a7234ecdf32dd1155e7216f34b9d1a71f680f3::pepemas {
    struct PEPEMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEMAS>(arg0, 6, b"PEPEMAS", b"PEPEXMAS", b"Safe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6419_87db7aa3fa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

