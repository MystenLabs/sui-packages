module 0x71c360cb08fd2b2f6aa946b969aeebebd8abf06e2944b7cf8bb685da6d9e354c::rizz {
    struct RIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RIZZ>(arg0, 6, b"RIZZ", b"Rizz AI by SuiAI", x"4c6574e2809973206d69782069742075702c204120436861726d696e67204167656e74206865726520746f2066696c6c20796f752075702077697468207468652062657374207669626573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6548_d776484baf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RIZZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

