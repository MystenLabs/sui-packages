module 0x420ab53fdb7057871c507c5df496e58838d017aacda31ea03257365eea16d75e::comedian {
    struct COMEDIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMEDIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMEDIAN>(arg0, 9, b"COMEDIAN", b"BAN", b"Banana on the wall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f03a80ca-4c2e-4498-9c7b-aad0b4d635ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMEDIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMEDIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

