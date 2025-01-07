module 0x31540cfad30256c505e18193ae492ff520bc443fbf13f597b939a84a22ffe5a1::bunnn {
    struct BUNNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BUNNN>(arg0, 6, b"BUNNN", b"TOKENA by SuiAI", b"BURN TOKENA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_12_31_08_55_53_68c5ad673f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUNNN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

