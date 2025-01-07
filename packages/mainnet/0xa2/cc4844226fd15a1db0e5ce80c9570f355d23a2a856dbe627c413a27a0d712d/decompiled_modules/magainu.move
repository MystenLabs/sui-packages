module 0xa2cc4844226fd15a1db0e5ce80c9570f355d23a2a856dbe627c413a27a0d712d::magainu {
    struct MAGAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAINU>(arg0, 6, b"MAGAINU", b"MAGA INU", b"Hello my name is MAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004925_6eb9e38326.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

