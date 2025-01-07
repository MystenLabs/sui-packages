module 0xb9641f28f1fa662ce81e8239eea9237ec87e7ce06efa3512b4909013157828a::save {
    struct SAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVE>(arg0, 6, b"SAVE", b"Sui Savings Cat", b"$SAVE at your own risk. This token is designed purely for fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1233_6d386fa831.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

