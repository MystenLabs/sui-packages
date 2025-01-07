module 0x285684979a668ff05ff9da1185616b73a2057a519fcfcbbce66afc43f85fa992::lastpush {
    struct LASTPUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LASTPUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASTPUSH>(arg0, 6, b"LASTPUSH", b"LAST PUSH", b"LASTPUSH.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YA_2_Q_Trz_LNZECP_Cf_V66buzp_ZGH_Wfd_Tou_Ffb_Tp_U_Sbzh_Eja_95f361db26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASTPUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LASTPUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

