module 0xb9124bd49b4b4b7625c52c4ba9832143a6cd480a75e9c040f1dffdc79d013c05::c99 {
    struct C99 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C99, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C99>(arg0, 6, b"C99", b"C99 Tea", b"100% Natural communi-Tea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017858_a5777f27c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C99>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<C99>>(v1);
    }

    // decompiled from Move bytecode v6
}

