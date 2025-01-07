module 0xcbc3139c515977a85ba42eb915a668ebd2d472ec02f1a01b7d30f6f3e3a5457a::upmm {
    struct UPMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPMM>(arg0, 6, b"UPMM", b"Up meme", b"Do you like me?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/up_meme2_2e255b100b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

