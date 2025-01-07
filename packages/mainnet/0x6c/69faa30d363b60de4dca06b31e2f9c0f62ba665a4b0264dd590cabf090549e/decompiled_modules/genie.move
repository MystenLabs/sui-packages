module 0x6c69faa30d363b60de4dca06b31e2f9c0f62ba665a4b0264dd590cabf090549e::genie {
    struct GENIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENIE>(arg0, 6, b"Genie", b"Sui Genie", b"Rub the bottle, make a wish, and let Sui Genie do the magic. Only 3 wishes? Nah, Sui Genies got limitless ATH potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_3_dbee8f9b0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

