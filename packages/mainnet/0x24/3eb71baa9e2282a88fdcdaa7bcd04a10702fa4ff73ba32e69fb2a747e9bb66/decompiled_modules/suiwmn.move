module 0x243eb71baa9e2282a88fdcdaa7bcd04a10702fa4ff73ba32e69fb2a747e9bb66::suiwmn {
    struct SUIWMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWMN>(arg0, 6, b"Suiwmn", b"Suiwoman", b"Suiwoman is destined to be by Suiman's side (in market cap). More art to come.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/240_F_105389703_5kwf_D0a_Iv_Slj9_D_Zra4riu_V_Zb_L10c_E2_VA_e2f0ab1244.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

