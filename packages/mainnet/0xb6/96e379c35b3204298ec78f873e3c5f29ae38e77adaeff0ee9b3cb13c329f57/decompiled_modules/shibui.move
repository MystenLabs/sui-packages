module 0xb696e379c35b3204298ec78f873e3c5f29ae38e77adaeff0ee9b3cb13c329f57::shibui {
    struct SHIBUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBUI>(arg0, 6, b"SHIBUI", b"Shiba SUI", x"0a20526561647920666f72206c6966742d6f6666206f6e2074686520537569204e6574776f726b3f200a446f6e74206d6973732061207468696e67666f6c6c6f77207573206f6e200a0a54776974746572203a582e636f6d2f73686962755f7375690a0a202353686962614f6e5355492023546f5468654d6f6f6e20235375694e6574776f726b202343727970746f526973696e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5814580107929568009_3e7e1ce5fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

