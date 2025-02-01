module 0xf6df5d82f66b74ceba4269891cbfff63f49f2e5f3d9e692d0fe1b7b49cc60a50::hal {
    struct HAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HAL>(arg0, 6, b"HAL", b"HAL 9000 by SuiAI", b"HAL 9000 is a sentient artificial intelligence computer that controls the systems of the spaceship Discovery One.  HAL is short for Heuristically Programmed Algorithmic Computer. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/HAL_9000_546e2ccc08.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

