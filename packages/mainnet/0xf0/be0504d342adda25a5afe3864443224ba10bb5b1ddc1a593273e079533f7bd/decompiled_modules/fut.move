module 0xf0be0504d342adda25a5afe3864443224ba10bb5b1ddc1a593273e079533f7bd::fut {
    struct FUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUT>(arg0, 6, b"Fut", b"The future", b"The future is gonna be fantastic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010684_56abe5864e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

