module 0x463150f04eb62e8362c81917533b03ab56177d6500b6861759a99a57d7056db::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 6, b"SPEPE", b"Sui Pepe", b"SuuuuuuuuuuuuuuuiPePe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_Ctr_NR_71_400x400_7d9bd6a5fc_f86b9fdffa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

