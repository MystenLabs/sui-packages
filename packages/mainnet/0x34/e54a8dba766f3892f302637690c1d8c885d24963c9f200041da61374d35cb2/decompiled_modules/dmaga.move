module 0x34e54a8dba766f3892f302637690c1d8c885d24963c9f200041da61374d35cb2::dmaga {
    struct DMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMAGA>(arg0, 6, b"DMAGA", b"Dark MAGA", x"4461726b204d4147412070617472696f747320696e20636f6e74726f6c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DMAGA_08498482af.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

