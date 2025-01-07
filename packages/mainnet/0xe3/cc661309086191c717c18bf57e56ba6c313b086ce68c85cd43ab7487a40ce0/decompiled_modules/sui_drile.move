module 0xe3cc661309086191c717c18bf57e56ba6c313b086ce68c85cd43ab7487a40ce0::sui_drile {
    struct SUI_DRILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_DRILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_DRILE>(arg0, 9, b"SUI DRILE", x"f09f908a537569204472696c65", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_DRILE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_DRILE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_DRILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

