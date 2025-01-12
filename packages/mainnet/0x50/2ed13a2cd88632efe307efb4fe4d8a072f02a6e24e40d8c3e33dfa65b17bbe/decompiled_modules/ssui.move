module 0x502ed13a2cd88632efe307efb4fe4d8a072f02a6e24e40d8c3e33dfa65b17bbe::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 6, b"SSui", b"SSUI", b"SSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/20947.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

