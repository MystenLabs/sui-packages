module 0xf114466769f74e27f13ed383930a9a4f10e5b8a22a8b0eda40582f3a2885d8aa::sadko {
    struct SADKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADKO>(arg0, 6, b"Sadko", b"Sadko of Novgorod", b"Slavic folklore comes to the Suiverse . . .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sadko_c2fa1ef811.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

