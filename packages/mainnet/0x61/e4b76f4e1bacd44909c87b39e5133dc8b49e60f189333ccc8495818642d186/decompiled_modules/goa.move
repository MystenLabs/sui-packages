module 0x61e4b76f4e1bacd44909c87b39e5133dc8b49e60f189333ccc8495818642d186::goa {
    struct GOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOA>(arg0, 6, b"GOA", b"Gulf Of America", b"Inspired by Gulf Of America", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741276256372.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

