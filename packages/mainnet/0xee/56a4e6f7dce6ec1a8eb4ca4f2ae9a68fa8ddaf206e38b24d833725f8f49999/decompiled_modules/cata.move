module 0xee56a4e6f7dce6ec1a8eb4ca4f2ae9a68fa8ddaf206e38b24d833725f8f49999::cata {
    struct CATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATA>(arg0, 9, b"cata", b"cat", b"cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipads.fun/api/files/suipump/logos/0x159ca760875b2e1713b7132559e0f50bc9e29a4e310816bc0683ab425ea814ce/6672fc8c-4530-40dc-b509-04e5cf161834.jpeg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATA>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATA>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

