module 0x2f4ba7dec5d3e239b1f3455ed9c3355ba9f951beab5c673efdb1e43b5e6902d4::thefed {
    struct THEFED has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEFED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEFED>(arg0, 6, b"TheFed", b"The Fed", b"A simple game about central banking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000125807_05e2ac388f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEFED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEFED>>(v1);
    }

    // decompiled from Move bytecode v6
}

