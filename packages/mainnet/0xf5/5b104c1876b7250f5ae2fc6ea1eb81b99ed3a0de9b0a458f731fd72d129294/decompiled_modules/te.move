module 0xf55b104c1876b7250f5ae2fc6ea1eb81b99ed3a0de9b0a458f731fd72d129294::te {
    struct TE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TE>(arg0, 6, b"TE", b"TrumpElon", b"Memecoin about the fantastic world of Trump and Elon Musk. Enjoy the community of crypto to make this world much bigger!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737813339170.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

