module 0xa50fe3ec8d9c524518b30cba8972c915f3ad3842c761effbc7688f20e3cd4ba4::yoyo {
    struct YOYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOYO>(arg0, 6, b"YOYO", b"Yoyo", b"Yoyo the freshest cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yoyo_f61702ac84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

