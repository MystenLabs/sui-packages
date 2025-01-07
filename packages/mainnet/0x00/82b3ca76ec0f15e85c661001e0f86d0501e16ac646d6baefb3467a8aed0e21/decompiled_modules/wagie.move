module 0x82b3ca76ec0f15e85c661001e0f86d0501e16ac646d6baefb3467a8aed0e21::wagie {
    struct WAGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGIE>(arg0, 6, b"WAGIE", b"Wagie On Sui", b"$WAGIE On Sui - Leave the 9-5 today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_5f81908583.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

