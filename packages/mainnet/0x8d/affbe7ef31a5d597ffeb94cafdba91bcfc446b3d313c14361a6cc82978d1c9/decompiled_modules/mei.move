module 0x8daffbe7ef31a5d597ffeb94cafdba91bcfc446b3d313c14361a6cc82978d1c9::mei {
    struct MEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEI>(arg0, 9, b"MEI", x"f09fa695", x"43616c6c206d65206973204d656920f09fa695", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97d4f792-5054-42b0-aaaa-033507c6a421.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

