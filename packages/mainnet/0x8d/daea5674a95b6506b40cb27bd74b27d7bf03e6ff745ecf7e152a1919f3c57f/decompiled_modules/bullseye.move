module 0x8ddaea5674a95b6506b40cb27bd74b27d7bf03e6ff745ecf7e152a1919f3c57f::bullseye {
    struct BULLSEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLSEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLSEYE>(arg0, 6, b"Bullseye", x"f09f8eaf42756c6c73657965f09f8eaf", x"f09f8eaff09f8eaff09f8eaff09f8eaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731710728093.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLSEYE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSEYE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

