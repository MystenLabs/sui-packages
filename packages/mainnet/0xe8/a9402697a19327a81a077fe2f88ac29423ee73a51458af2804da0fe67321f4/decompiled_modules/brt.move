module 0xe8a9402697a19327a81a077fe2f88ac29423ee73a51458af2804da0fe67321f4::brt {
    struct BRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRT>(arg0, 6, b"BRT", b"BRUT", b"Burt is going to be an adult soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6425394876_36773bf965.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

