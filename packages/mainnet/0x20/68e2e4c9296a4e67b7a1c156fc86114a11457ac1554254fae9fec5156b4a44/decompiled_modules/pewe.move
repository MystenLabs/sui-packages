module 0x2068e2e4c9296a4e67b7a1c156fc86114a11457ac1554254fae9fec5156b4a44::pewe {
    struct PEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEWE>(arg0, 9, b"PEWE", b"PEWE Frog", b"PEWE - the one and only legit FROG on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71edca4b-9008-41fc-a75b-5f39b53aebab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

