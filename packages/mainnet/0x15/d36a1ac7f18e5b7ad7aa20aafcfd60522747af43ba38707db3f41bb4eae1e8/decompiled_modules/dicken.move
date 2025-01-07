module 0x15d36a1ac7f18e5b7ad7aa20aafcfd60522747af43ba38707db3f41bb4eae1e8::dicken {
    struct DICKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICKEN>(arg0, 6, b"DICKEN", b"dicken", x"77686963682063616d652066697273742c2074686520646f67206f722074686520636869636b656e3f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vir_Jc4_Noksa_Srr_K_Tc_LE_Ybwyw8j7dd_JT_Taji_Rp_Fh_Kr_Ns_Z_56c70d4311.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

