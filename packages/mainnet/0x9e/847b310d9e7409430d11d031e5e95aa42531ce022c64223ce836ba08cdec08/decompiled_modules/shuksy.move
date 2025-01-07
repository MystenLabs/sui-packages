module 0x9e847b310d9e7409430d11d031e5e95aa42531ce022c64223ce836ba08cdec08::shuksy {
    struct SHUKSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUKSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUKSY>(arg0, 6, b"SHUKSY", b"SUIHUSKY", b"SUI HUSKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3cbc35eb4fc837f6bdc09daeff554d07_064f1fbefd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUKSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUKSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

