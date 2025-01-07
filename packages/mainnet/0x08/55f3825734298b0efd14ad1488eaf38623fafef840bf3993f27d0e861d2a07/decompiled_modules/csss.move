module 0x855f3825734298b0efd14ad1488eaf38623fafef840bf3993f27d0e861d2a07::csss {
    struct CSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSSS>(arg0, 6, b"CSSS", b"ChopSui & SuiSauce", b"This dynamic duo protects their investors from rug pulls and jeeter devs.  Created for the real holders and diamond hands on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_Wqxvrr8t_HPTQH_Ahu_X6_LZ_Fz_1_730b19e3b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

