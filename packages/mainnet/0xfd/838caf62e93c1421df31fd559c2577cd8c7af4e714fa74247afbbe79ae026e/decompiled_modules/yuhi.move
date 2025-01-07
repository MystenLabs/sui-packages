module 0xfd838caf62e93c1421df31fd559c2577cd8c7af4e714fa74247afbbe79ae026e::yuhi {
    struct YUHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUHI>(arg0, 6, b"YUHI", b"Yuhi Max Kudasai", b"Yuhi from KudasaiJP - Inspiration from members who love memes and anime in Japan. https://www.yuhi.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_d67b2475da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

