module 0x81e47d1faf5340dd81adc07a9631458704c75dd5d8ef8374d7f9448ff4b4d40::chip {
    struct CHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIP>(arg0, 6, b"CHIP", b"Sui Blue Chip", b"A blue potato mfer stands alone as the sole blue-chip memecoin on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dov_952223644e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

