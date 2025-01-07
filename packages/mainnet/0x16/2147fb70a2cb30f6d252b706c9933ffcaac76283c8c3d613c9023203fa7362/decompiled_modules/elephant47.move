module 0x162147fb70a2cb30f6d252b706c9933ffcaac76283c8c3d613c9023203fa7362::elephant47 {
    struct ELEPHANT47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEPHANT47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEPHANT47>(arg0, 6, b"Elephant47", b"El47", b"Donald Trump, 47 president of USA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/el_3e7f9900da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEPHANT47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEPHANT47>>(v1);
    }

    // decompiled from Move bytecode v6
}

