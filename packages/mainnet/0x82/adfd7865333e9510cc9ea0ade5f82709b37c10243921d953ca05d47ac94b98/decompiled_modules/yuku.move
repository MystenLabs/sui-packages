module 0x82adfd7865333e9510cc9ea0ade5f82709b37c10243921d953ca05d47ac94b98::yuku {
    struct YUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKU>(arg0, 9, b"Yuku", b"Yuku", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YUKU>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

