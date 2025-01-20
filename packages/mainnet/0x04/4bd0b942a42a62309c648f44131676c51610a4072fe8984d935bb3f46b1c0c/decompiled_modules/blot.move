module 0x44bd0b942a42a62309c648f44131676c51610a4072fe8984d935bb3f46b1c0c::blot {
    struct BLOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOT>(arg0, 6, b"BLOT", b"Blot", b"Just an indestructible green blot with zero chill and no plans for world dominationonly pure, unfiltered blot energy. He was left for dead once, but the funny thing is, what is blot may never die. Hold Blot, watch it wiggle, and embrace the goo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VJR_2iyu_Xzo_W_Tisrb4_Cr97hawptsb_ML_Bywa_E6_DGJ_Wp_GPF_35ed9027bf.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

