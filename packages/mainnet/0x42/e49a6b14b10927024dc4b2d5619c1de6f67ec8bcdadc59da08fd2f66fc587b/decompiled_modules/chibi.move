module 0x42e49a6b14b10927024dc4b2d5619c1de6f67ec8bcdadc59da08fd2f66fc587b::chibi {
    struct CHIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIBI>(arg0, 9, b"CHIBI", b"RABITCHIBI", b"Do you love chibi ???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1517fdf4-461c-4ca6-8afc-645f097eaaec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

