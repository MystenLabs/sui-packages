module 0x62ef24b981aa05b41467234c52f2b4b9e2967df6ed840cf45306135d2ef8ba48::doisi {
    struct DOISI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOISI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOISI>(arg0, 6, b"DOISI", b"The doisi coin", b"DOISI IS DOGESUI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042377_20dba1ebbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOISI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOISI>>(v1);
    }

    // decompiled from Move bytecode v6
}

