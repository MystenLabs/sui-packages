module 0x8003a45ffeffb0208e80049b76663d9457b77a260c31e2468467a846301e4102::suiduck {
    struct SUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCK>(arg0, 6, b"SUIDUCK", b"Poke Sui Duck", b"Suiduck is the new SUI Pokemon on the SUI chain! Suiduck is the SUICUNE'S friend. LEts go with he to millions!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_09_18_200346_08b5d97d22_bd66212dd6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

