module 0x5a6ee07d87269c26b4ac54197b768b73dc58a5a22f852fa0291df6191007aa52::sbaby {
    struct SBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBABY>(arg0, 6, b"SBABY", b"SUIBABY", b"The child born from Superman and Supergirl would be a powerful being, inheriting the incredible abilities of both Kryptonians", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blondxx_superbaby_cartoon_meme_no_logo_ar_11_v_6111_b021ca76b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

