module 0xe0009079cbf72cff499679476d9f9eafc6f291a4c8c11ef5f621fca34e191c55::kkong {
    struct KKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKONG>(arg0, 6, b"KKONG", b"KINGKONG SUI", b"KING KONG EATING BANANA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/25494148c53da6e36313b8df58ee39d7_5713ac114a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

