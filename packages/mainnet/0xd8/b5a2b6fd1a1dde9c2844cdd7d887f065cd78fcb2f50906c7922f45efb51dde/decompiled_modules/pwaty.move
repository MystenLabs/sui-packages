module 0xd8b5a2b6fd1a1dde9c2844cdd7d887f065cd78fcb2f50906c7922f45efb51dde::pwaty {
    struct PWATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWATY>(arg0, 6, b"PWATY", b"Pwaty", b"Pwaty short for Pwartypus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734706656593.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWATY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWATY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

