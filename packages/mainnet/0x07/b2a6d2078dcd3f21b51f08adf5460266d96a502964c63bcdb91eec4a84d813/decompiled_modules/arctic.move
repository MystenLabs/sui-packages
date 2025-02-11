module 0x7b2a6d2078dcd3f21b51f08adf5460266d96a502964c63bcdb91eec4a84d813::arctic {
    struct ARCTIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCTIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCTIC>(arg0, 6, b"ARCTIC", b"ARCTIC ON SUI", b"The water is starting to freeze. The arctic is finally on SUI... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739233497148.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARCTIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCTIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

