module 0x9f3961b286fd6e9d172971f8f8599a884565cf472f1c602fbaf1e02618846604::suins {
    struct SUINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINS>(arg0, 6, b"SuiNS", b"SUI Name Service", b"Your web3 MEME for all things Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ks_Jhgf_T_Wt_N_Fs8z_J005d_Dd_PS_Dgg_copia_03605b2010.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

