module 0x2191336791b15e71a2e01a7ccd09a93a2fc183921662a0abb1d07cda6e2aafd::suiape {
    struct SUIAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPE>(arg0, 6, b"SUIAPE", b"BRAZILIAN APE", b"LETS DO IT FOR BRAZIL'S RAINFORESTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BAPECLUB_27aaa9f234.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

