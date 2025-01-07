module 0x2c3e46ae5d0f7a0c50909fcbe290e4b134033f1a7457b213e58de50efedce0a7::wofl {
    struct WOFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOFL>(arg0, 6, b"WOFL", b"Wofl the wolf", b"he's crazy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_184952_8e43b98a74.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

