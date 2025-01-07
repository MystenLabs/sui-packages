module 0x5912f8bfa0a9447be85905d99e2f7c21b60b05b395fa3e5b018ac7883f66efbc::beep {
    struct BEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEP>(arg0, 6, b"BEEP", b"Beepy", b"Beepy is the first truly racist AI on Sui. Join our telegram or tweet at him on twitter to help him grow even more hateful! Trained on 100,000 pieces of pure hatred from 4chan.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/57k_G_Hu_Fyd4_Nvm_Zi_T8c_E9rd8u_Abxz_U72e_EUJN_Fcp1pump_f479aa522c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

