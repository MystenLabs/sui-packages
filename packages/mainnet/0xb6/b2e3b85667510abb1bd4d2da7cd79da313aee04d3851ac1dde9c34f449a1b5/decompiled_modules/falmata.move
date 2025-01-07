module 0xb6b2e3b85667510abb1bd4d2da7cd79da313aee04d3851ac1dde9c34f449a1b5::falmata {
    struct FALMATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALMATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALMATA>(arg0, 9, b"FALMATA", b"RIERIE", b"RIERIE is a nickname of someone girlfriend inspired by him and took it personal to drive it on wave Blockchain to prove the existance of love and care.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b122c2ff-81e5-40ee-8936-e4e7d6fc33b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALMATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FALMATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

