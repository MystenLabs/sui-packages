module 0x3e58dcf3f4bacabe21cfda7c3201f0e5516bdc5d30a745045177719f1ea6e6a2::dong {
    struct DONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONG>(arg0, 9, b"DONG", x"c4906f6e67", x"c490c3b46e67204cc3aa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da54d02b-dbdf-434a-8b1c-692d1f12dd26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

