module 0x7f4452934f282448dd05729f02f92fab4e52ede802fc491975f2eb0fb0b015db::srwd {
    struct SRWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRWD>(arg0, 6, b"SRWD", b"SRWD GUY", b"Tired of Scam? So are we join the revolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014017_343c5a6ba9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRWD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

