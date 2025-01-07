module 0x58d5fc691457e9c10b664bf1c440ef3434e4bcd228df5426d78ddedeeef14a56::sr2 {
    struct SR2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SR2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SR2>(arg0, 9, b"SR2", b"Sambasui", b"Sambasui is a meme token inspired by the name of our ancestor Alu Sambare who is descendants of a the famous son of Muhammad gwaya who ruled Bakura,a province in zamfara state from (1825-1836)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28faf70d-dbba-42e1-a0cd-10e9958609ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SR2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SR2>>(v1);
    }

    // decompiled from Move bytecode v6
}

