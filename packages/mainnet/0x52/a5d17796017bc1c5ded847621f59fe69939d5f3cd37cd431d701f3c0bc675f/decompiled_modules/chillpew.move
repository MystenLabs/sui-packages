module 0x52a5d17796017bc1c5ded847621f59fe69939d5f3cd37cd431d701f3c0bc675f::chillpew {
    struct CHILLPEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLPEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLPEW>(arg0, 9, b"CHILLPEW", b"PEWPEW On Sui", b"PEWPEW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/a09a162f48aee424a1cd8ed520b4e501blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLPEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLPEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

