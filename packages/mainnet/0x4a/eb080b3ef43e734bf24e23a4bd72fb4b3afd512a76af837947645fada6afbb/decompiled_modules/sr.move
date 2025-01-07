module 0x4aeb080b3ef43e734bf24e23a4bd72fb4b3afd512a76af837947645fada6afbb::sr {
    struct SR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SR>(arg0, 9, b"SR", b"Sajadsr", b"1vs1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f152f30-40ff-4d30-8690-6fd7075b58ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SR>>(v1);
    }

    // decompiled from Move bytecode v6
}

