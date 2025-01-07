module 0x90bd551e13885fae887e31d600a1a1528fc4ebaeeb1668383e81c19034bcb4fe::tacc {
    struct TACC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TACC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TACC>(arg0, 6, b"TACC", b"Cult Cat", b"TTAC is the cat from hell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_400657641e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TACC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TACC>>(v1);
    }

    // decompiled from Move bytecode v6
}

