module 0xc019b630d084159164b5e34f4e9a8cfe044dc5514b8095fa06d1ac9a93f8b03f::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PIZZA>(arg0, 6, b"PIZZA", x"446f6d696e6fe2809973206279205375694149", b"Pizza Lyfe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8211_9be912b8bc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIZZA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

