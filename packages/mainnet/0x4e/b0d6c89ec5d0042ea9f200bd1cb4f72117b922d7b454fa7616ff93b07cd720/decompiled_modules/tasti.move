module 0x4eb0d6c89ec5d0042ea9f200bd1cb4f72117b922d7b454fa7616ff93b07cd720::tasti {
    struct TASTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TASTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TASTI>(arg0, 6, b"Tasti", b"testi", b"tastiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_06_14_14_48_56_559a6a8c8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TASTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TASTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

