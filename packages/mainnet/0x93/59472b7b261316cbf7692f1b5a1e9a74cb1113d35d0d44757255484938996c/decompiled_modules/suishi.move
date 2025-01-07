module 0x9359472b7b261316cbf7692f1b5a1e9a74cb1113d35d0d44757255484938996c::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"Suishi", b"Tastiest fish in the sea of agents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2746_a6c2944447.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISHI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

