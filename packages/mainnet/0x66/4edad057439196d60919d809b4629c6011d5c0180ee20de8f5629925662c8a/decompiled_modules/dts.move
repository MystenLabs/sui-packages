module 0x664edad057439196d60919d809b4629c6011d5c0180ee20de8f5629925662c8a::dts {
    struct DTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTS>(arg0, 6, b"DTS", b"DuckTrumpSui", b"DuckTrump welcomes all players to the $DTS coin in the SuiNetwork system.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_1_c05870f9af.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

