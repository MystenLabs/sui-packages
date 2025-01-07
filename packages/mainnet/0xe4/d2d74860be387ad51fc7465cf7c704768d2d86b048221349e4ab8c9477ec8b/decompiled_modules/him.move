module 0xe4d2d74860be387ad51fc7465cf7c704768d2d86b048221349e4ab8c9477ec8b::him {
    struct HIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIM>(arg0, 6, b"HIM", b"Holding Is Mandatory", b"He is Him.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q_Qpxwg_FF_6nvr_Mb7a_PX_3yw_Tkgwqoyn_K_Mp_Yqua26_Jf_W8_AZ_1ab336bc8f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

