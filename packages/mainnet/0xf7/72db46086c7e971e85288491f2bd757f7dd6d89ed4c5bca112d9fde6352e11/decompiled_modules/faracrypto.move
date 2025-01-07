module 0xf772db46086c7e971e85288491f2bd757f7dd6d89ed4c5bca112d9fde6352e11::faracrypto {
    struct FARACRYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARACRYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARACRYPTO>(arg0, 9, b"FARACRYPTO", b"Fara", b"New meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65dab0a6-4f28-4503-93d3-1efc8263ae6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARACRYPTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARACRYPTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

