module 0xf431c0ed4bd96b7317d5f062d7a8cbd7d354a10b53e191aa673fbd6d3b66d284::suika {
    struct SUIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKA>(arg0, 6, b"SUIKA", b"SUIKA on SUI", b"SUIKA is a unique Shiba Inu project on the Sui network. Boasting heavy eye-liner, a spiky choker, Sui colored hair and an an attitude to match, she really is a bad bitch of the blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGOSUIKA_eb47a352de.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

