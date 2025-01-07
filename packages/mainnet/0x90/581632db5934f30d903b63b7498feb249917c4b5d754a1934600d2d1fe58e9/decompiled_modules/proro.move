module 0x90581632db5934f30d903b63b7498feb249917c4b5d754a1934600d2d1fe58e9::proro {
    struct PRORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRORO>(arg0, 6, b"PRORO", b"Pororo", x"68656c6c6f2e0a506f726f726f20686173206170706561726564212120416c6c20667269656e6473206172652077656c636f6d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_03_05_16_c4d49f7ced.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

