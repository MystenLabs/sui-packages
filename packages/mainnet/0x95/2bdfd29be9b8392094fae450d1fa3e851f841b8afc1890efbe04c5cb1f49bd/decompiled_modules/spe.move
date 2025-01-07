module 0x952bdfd29be9b8392094fae450d1fa3e851f841b8afc1890efbe04c5cb1f49bd::spe {
    struct SPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPE>(arg0, 6, b"SPE", b"SUIPE", b"IM PEPE ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xd61d4f7c996bd192d5b580686c37a48107f055a620eb353ccc756c36f9cf04dd_pepsui_pepsui_09435d3e91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

