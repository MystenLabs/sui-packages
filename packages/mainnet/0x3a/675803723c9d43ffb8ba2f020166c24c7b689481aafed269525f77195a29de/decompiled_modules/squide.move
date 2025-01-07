module 0x3a675803723c9d43ffb8ba2f020166c24c7b689481aafed269525f77195a29de::squide {
    struct SQUIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDE>(arg0, 6, b"SQUIDE", b"Squide", x"54686520506561726c206f66205355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_movepump_ca97a235ee_be91692707.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

