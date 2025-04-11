module 0xb3675433bdc86700e35fc0b5a3dd1a3650fee346e8d38a341ebaf7522363e042::coffee {
    struct COFFEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFEE>(arg0, 6, b"COFFEE", b"SUI COFFEE", x"464952535420434f46464545204d41444520425920535549205452414e53414354494f4e2e20537569e280997320736f20706f77657266756c2c206974206d69676874206576656e206d616b6520636f666665652120e29895efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1744402122040.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COFFEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

