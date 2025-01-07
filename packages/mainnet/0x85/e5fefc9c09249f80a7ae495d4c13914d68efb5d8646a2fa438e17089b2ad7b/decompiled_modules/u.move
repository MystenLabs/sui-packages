module 0x85e5fefc9c09249f80a7ae495d4c13914d68efb5d8646a2fa438e17089b2ad7b::u {
    struct U has drop {
        dummy_field: bool,
    }

    fun init(arg0: U, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<U>(arg0, 0, b"U", b"Token Utility", b"Token Utility For testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tokenutility.io/images/logo-mobile.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<U>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<U>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<U>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<U>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

