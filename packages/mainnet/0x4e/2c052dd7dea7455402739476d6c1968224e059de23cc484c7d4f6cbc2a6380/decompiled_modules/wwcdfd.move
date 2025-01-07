module 0x4e2c052dd7dea7455402739476d6c1968224e059de23cc484c7d4f6cbc2a6380::wwcdfd {
    struct WWCDFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWCDFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWCDFD>(arg0, 6, b"WWcdfd", b"3345", b"asfggregerwwr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bdfbhfsdbhx_7a350b522f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWCDFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWCDFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

