module 0x92869c86826907fc04f82008d20fbe891a01de1661beaa4d9b3007a755616e80::say {
    struct SAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAY>(arg0, 9, b"SAY", b"Nt", b"Yes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c281055d-a423-4efc-aec9-c36a60c21d1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

