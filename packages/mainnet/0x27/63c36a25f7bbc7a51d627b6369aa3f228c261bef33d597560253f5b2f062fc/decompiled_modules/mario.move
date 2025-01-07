module 0x2763c36a25f7bbc7a51d627b6369aa3f228c261bef33d597560253f5b2f062fc::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIO>(arg0, 6, b"MARIO", b"First Mario on SUI", b"First Mario on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/logoofufufu_7009cb6bb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

