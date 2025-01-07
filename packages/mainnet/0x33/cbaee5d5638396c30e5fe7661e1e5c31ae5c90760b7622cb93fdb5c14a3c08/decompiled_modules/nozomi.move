module 0x33cbaee5d5638396c30e5fe7661e1e5c31ae5c90760b7622cb93fdb5c14a3c08::nozomi {
    struct NOZOMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOZOMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOZOMI>(arg0, 6, b"Nozomi", b"nozomi", b"Nozomi is the comics from Evan the SUI CEO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240930134847_095bccbad7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOZOMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOZOMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

