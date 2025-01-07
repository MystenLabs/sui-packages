module 0xa195a89f6926e54ac999e57fde69f926a4818aa0d3640b60f60494b60e08bf70::mctrump {
    struct MCTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCTRUMP>(arg0, 6, b"MCTRUMP", b"McTrump", b"McTrump lost all his life savings and ended up at McSui - He is now working overtime to put that $$$ back into crypto to finally make it out of the 9-5.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_6_dedbd038eb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

