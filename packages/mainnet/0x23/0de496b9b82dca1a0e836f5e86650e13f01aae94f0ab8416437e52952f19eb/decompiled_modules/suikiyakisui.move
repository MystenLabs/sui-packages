module 0x230de496b9b82dca1a0e836f5e86650e13f01aae94f0ab8416437e52952f19eb::suikiyakisui {
    struct SUIKIYAKISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKIYAKISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKIYAKISUI>(arg0, 6, b"SUIKIYAKISUI", b"SUIKIYAKI", b"The most delicious meal-coin on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_D_D_7fc6f9b487.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKIYAKISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKIYAKISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

