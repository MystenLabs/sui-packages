module 0x1db6493eb66c84cbaded47078b03c877663408ecedf55484b7086e7e9a4293a5::suius {
    struct SUIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUS>(arg0, 6, b"SUIUS", b"Suius", b"Suius, once Zeus, now commands Sui. His lightning powers the market, sparking huge electric green candles for all who joins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_2_9d54966436.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

