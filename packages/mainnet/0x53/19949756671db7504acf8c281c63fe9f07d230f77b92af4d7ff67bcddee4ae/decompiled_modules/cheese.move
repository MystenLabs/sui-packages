module 0x5319949756671db7504acf8c281c63fe9f07d230f77b92af4d7ff67bcddee4ae::cheese {
    struct CHEESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEESE>(arg0, 6, b"Cheese", b"cheeseball", b"The cute fat wizard cat as $cheese", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_15_a0f343c96e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

