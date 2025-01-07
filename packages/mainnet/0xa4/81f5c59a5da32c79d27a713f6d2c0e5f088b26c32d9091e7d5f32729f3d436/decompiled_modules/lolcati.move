module 0xa481f5c59a5da32c79d27a713f6d2c0e5f088b26c32d9091e7d5f32729f3d436::lolcati {
    struct LOLCATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLCATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLCATI>(arg0, 6, b"LOLCATI", b"LOLCAT", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035189_201ea2752f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLCATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLCATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

