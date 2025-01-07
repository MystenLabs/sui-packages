module 0xd82532667ac325b5f5d00efd46155871234cff6d7786ebb8b7e7d6af421be764::joel {
    struct JOEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOEL>(arg0, 6, b"Joel", b"JOEL", b"Joel Joel Joel Joel Joel Joel Joel Joel Joel Joel Joel Joel Joel Joel Joel Joel Joel Joel ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/JACSU_5f2f_Cs_QSCD_Nz1_VX_2_Se4vm_Qyj8k5_E_Yig_D4_Rppv_GV_ef1652175b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

