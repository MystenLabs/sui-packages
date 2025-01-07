module 0x4980760b162ffdca74c72dbea12349a09889c4e48a229c73e118373d15400e53::billi {
    struct BILLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLI>(arg0, 9, b"BILLI", b"Billionair", b"Awesome and good project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/625ace51-710f-4fc6-82bf-23eb9d955a65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

