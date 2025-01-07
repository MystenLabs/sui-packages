module 0x923bd609b9c905569cf3f025c4d7e9a1134fa365e04790956c7c6a7fe8d10c24::ego {
    struct EGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGO>(arg0, 6, b"EGO", b"Ego", b"We all have one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1365_980fe909e4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

