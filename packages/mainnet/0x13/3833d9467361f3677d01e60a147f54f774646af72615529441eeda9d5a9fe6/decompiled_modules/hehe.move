module 0x133833d9467361f3677d01e60a147f54f774646af72615529441eeda9d5a9fe6::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHE>(arg0, 6, b"HEHE", b"HEHE ON SUI", b"HEHE HEHE HEHE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7023_1fb5396c30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

