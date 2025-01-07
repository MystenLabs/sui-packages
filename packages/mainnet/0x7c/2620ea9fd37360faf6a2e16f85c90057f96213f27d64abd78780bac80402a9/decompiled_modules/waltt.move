module 0x7c2620ea9fd37360faf6a2e16f85c90057f96213f27d64abd78780bac80402a9::waltt {
    struct WALTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALTT>(arg0, 6, b"WALTT", b"Waltt the Walrus", b"Waltt, Brett's lost cousin with fearless tusks is ready to dominate Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_d95f32d754.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

