module 0x60a19bfe101c72228fb8c38f17562f0e19ca933a555b9e28a59b68de3a3e3355::vpug {
    struct VPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: VPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VPUG>(arg0, 6, b"VPUG", b"Vitruvian Pug", b"The Vitruvian Pug, born from the stars, is said to embody the perfect balance between loyalty and mischief, a guardian of ancient wisdom hidden within its wrinkled brow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5cec19f3722c05bc6378bd80e9ab907b_94993d0eed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

