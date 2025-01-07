module 0xf0cbbaeb7a0b92987a299d4e3ff8e40adb41844bcd4866dafcdb6e9d84dc9077::pat {
    struct PAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAT>(arg0, 6, b"PAT", b"Pat the Cat", b"$PAT - Just a cat with a mission to bring more traders to Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XZ_5_As_Kut1opxd_Kqm_Q_Jrxib_Ao_K7ff_C_Qt6_N9_M4i_N9bp_Hfa_f30986b192.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

