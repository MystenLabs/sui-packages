module 0xe021d07fe1c9a5bca27e6885d9b0cdb59d18ab00dcf656af8bdcf108da04fd7::suidine {
    struct SUIDINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDINE>(arg0, 6, b"SUIDINE", b"Suidine", b"Suidine is here to outsmart the big fishes of sui - proving that even the smallest can make big waves when they swim as one.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_3_df77b4c829.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

