module 0x65413f4ef64424b5bd10a2abef91f612bb0bf384b85d06c83c95e87f7534680b::chewy {
    struct CHEWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEWY>(arg0, 6, b"CHEWY", b"Chewy On Sui", b"First Wookie On Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730996011588.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEWY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEWY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

