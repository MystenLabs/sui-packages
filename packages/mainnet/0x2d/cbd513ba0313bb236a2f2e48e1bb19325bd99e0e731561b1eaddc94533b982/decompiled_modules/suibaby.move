module 0x2dcbd513ba0313bb236a2f2e48e1bb19325bd99e0e731561b1eaddc94533b982::suibaby {
    struct SUIBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBABY>(arg0, 6, b"SuiBaby", b"SUIBABY", b"The child born from Suiman and Suigirl would be a powerful being, inheriting the incredible abilities of both Kryptonians", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blondxx_superbaby_cartoon_meme_no_logo_ar_11_v_6111_cd6d193773.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

