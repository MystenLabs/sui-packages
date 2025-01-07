module 0x57203c20390dd6fdf7324d28151fd081100cfd9383971d55a58148b04c8a61ca::marcat {
    struct MARCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARCAT>(arg0, 9, b"MARCAT", b"Marcoin", b"An innovative creation of a universal transformation of next generation token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4f0a064-1ce5-4ba7-8bac-ab27066c527e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

