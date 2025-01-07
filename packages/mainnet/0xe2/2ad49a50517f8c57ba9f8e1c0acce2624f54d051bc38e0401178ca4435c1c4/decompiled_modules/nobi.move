module 0xe22ad49a50517f8c57ba9f8e1c0acce2624f54d051bc38e0401178ca4435c1c4::nobi {
    struct NOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBI>(arg0, 6, b"NOBI", b"NOBIKO", b"In other words, we don't know where $COZCAT went.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_V_Vkxm5_400x400_5429ef7fd5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

