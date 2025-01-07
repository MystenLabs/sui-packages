module 0x23f3946c3b4f4fa8ee16d71e48a3a3925085eca2237e06c3d4e7f65dc0bcb20::bstd {
    struct BSTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSTD>(arg0, 6, b"BSTD", b"BABY SUITARD", b"Suitard - is the memecoin on sui that made 40X for one day. Baby Suitard - this is his baby.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BABY_SUITARD_91461fc67c_8107dcd1a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

