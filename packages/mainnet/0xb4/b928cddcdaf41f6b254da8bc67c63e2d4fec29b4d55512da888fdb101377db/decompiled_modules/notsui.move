module 0xb4b928cddcdaf41f6b254da8bc67c63e2d4fec29b4d55512da888fdb101377db::notsui {
    struct NOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTSUI>(arg0, 6, b"NOTSUI", b"Not sui coin", b"Not sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000097910_1d37a5dfbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

