module 0x31878264f058b7941a202cb194631967337463659fde445843b4ad4c7362906d::dymo {
    struct DYMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYMO>(arg0, 6, b"DYMO", b"DYMOND", x"746865206861726465737420666f726d206f662063727970746f2e0a66726f6d207a65726f20746f206865726f20242424", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747772487952.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DYMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

