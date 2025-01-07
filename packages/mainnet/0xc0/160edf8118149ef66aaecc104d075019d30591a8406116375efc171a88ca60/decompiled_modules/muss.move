module 0xc0160edf8118149ef66aaecc104d075019d30591a8406116375efc171a88ca60::muss {
    struct MUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSS>(arg0, 9, b"MUSS", b"Mustache S", b"Mustache Strength", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c994d198-63aa-42d9-9c4d-78e63cf723f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

