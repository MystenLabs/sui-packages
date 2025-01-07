module 0x3f01ec5c0519b8054c7c7d9aef56550c0c7c4d1c7ddcc6cc7b84e2a8a30719da::nvda6900 {
    struct NVDA6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVDA6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVDA6900>(arg0, 6, b"NVDA6900", b"nvda6900", b"Never Volatile Definitely Ape 6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K8x1x9_W9_400x400_bb34c8c6e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NVDA6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NVDA6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

