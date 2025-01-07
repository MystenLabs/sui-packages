module 0x58d735d435820ccef05df4ddbb2c4697c053a12e79d179e9c33545180d68d06d::wedogs {
    struct WEDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOGS>(arg0, 9, b"WEDOGS", b"Dog's", b"Lets do fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cdab351-dd47-4fdf-885a-bc7f362aa47e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

