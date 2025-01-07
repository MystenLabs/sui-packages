module 0x9e0274ae41e8f5c611a05ae69ff518060eb2e7875de83c1f0f73a41f6da6944::cate {
    struct CATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATE>(arg0, 6, b"CATE", b"CATE ON SUI", b"Cat but with an E ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_14_19_36_52_104c325892.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

