module 0x49016d7b10323ccad6bbbceba0371caf25a7ef81061b6bd450ddd72766085177::saa {
    struct SAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAA>(arg0, 9, b"SAA", b"ADF", b"SF is a bit of a bit of a bit of a ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7140ebf5-0fcf-4ab8-93f5-c5448ed5a4b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

