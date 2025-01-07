module 0x63716979679b8624007b91d58b601cb7dcb85f224cb31c3949fa7a8cdfeb90d9::pigsui {
    struct PIGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGSUI>(arg0, 6, b"Pigsui", b"Pigsui Man", b"Hero of Sui town", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jpegozan_ef88359b0d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

