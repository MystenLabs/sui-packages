module 0x51f448a2da25aff22768ae34842f5ed37de99d4560b3ae634709d2688e904036::voci {
    struct VOCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOCI>(arg0, 6, b"VOCI", b"Voci AI", x"24564f4349202d2054686520756c74696d61746520416c20706c6174666f726d206861726e657373696e672074686520626f756e646c6573736e657373206f66206b6e6f776c656467652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736726356430.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOCI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOCI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

