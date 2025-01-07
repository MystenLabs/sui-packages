module 0x5bf2656f2b45fc221ca8570b307704baf9fa756a8a0908e57f584378a920d806::spike {
    struct SPIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIKE>(arg0, 6, b"SPIKE", b"SPIKE SUI", x"4d617474204675726965277320666972737420646f63756d656e7465642064726177696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Ng_H_Ns445_R95ownh4_SR_96f_Ryf_BC_Wbn_SCWVV_Edr_T8_ZW_Wor_22d936f24e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

