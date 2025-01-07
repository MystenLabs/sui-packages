module 0xd01bbf41bae38bb38bd8959239a17cf9c1fdd6b4996197b8ee36a92bb6e0f04e::fwog {
    struct FWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOG>(arg0, 6, b"FWOG", b"Sui Fwog", b"The cute and lovely Fwog is coming to Sui forest.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suifwog.xyz/images/suifwog_icon.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FWOG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FWOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

