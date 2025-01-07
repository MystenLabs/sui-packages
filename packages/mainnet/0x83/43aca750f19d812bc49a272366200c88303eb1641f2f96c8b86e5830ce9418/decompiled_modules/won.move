module 0x8343aca750f19d812bc49a272366200c88303eb1641f2f96c8b86e5830ce9418::won {
    struct WON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WON>(arg0, 6, b"WON", b"WONSUI", b"WONSUI MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Toh_N_Hqms_N_Ryyyye_VW_Lvs_Xrxn_UG_Dq_ECKGFLC_3po_Ct13_B9_c91e127b87.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WON>>(v1);
    }

    // decompiled from Move bytecode v6
}

