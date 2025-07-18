module 0x20e8bb0d5eb87e4d21798767fff4f497422820d60d3badfe6c6d8cc6aff688cf::goth {
    struct GOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GOTH>(arg0, 6, b"GOTH", b"AI GOTH GIRL", b"https://t.me/gothsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/5393490909955486886_09be430619.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOTH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

