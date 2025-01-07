module 0x73f733868b76e424964433d869060df43e143b5661cf3877a30ef43021548c97::j33t {
    struct J33T has drop {
        dummy_field: bool,
    }

    fun init(arg0: J33T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J33T>(arg0, 6, b"J33t", b"Jeet", b"jeet is the test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_1_26a4b1795b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J33T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<J33T>>(v1);
    }

    // decompiled from Move bytecode v6
}

