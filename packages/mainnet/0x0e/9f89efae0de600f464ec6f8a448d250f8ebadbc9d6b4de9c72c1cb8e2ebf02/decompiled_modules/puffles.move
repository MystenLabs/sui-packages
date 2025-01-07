module 0xe9f89efae0de600f464ec6f8a448d250f8ebadbc9d6b4de9c72c1cb8e2ebf02::puffles {
    struct PUFFLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFLES>(arg0, 6, b"PUFFLES", b"Puffles of SUI", b"Puffles are small, furry, and spherical creatures from the ever so famous Club Penguin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcc_Gx1_Cygt_YM_Xmpfr_Khkac_Ug_Ry_Qo1_V_Fo_MSNW_Ygmo_RT_So_Z_6cbf0be823.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

