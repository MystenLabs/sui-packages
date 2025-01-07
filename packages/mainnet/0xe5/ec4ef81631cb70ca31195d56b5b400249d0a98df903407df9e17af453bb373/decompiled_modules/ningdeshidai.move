module 0xe5ec4ef81631cb70ca31195d56b5b400249d0a98df903407df9e17af453bb373::ningdeshidai {
    struct NINGDESHIDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINGDESHIDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINGDESHIDAI>(arg0, 6, b"NingDeShiDai", b"300750", b"NingDeShiDai  300750", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_5011b281d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINGDESHIDAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINGDESHIDAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

