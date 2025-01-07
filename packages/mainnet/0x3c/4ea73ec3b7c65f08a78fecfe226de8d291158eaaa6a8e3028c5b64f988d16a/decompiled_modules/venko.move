module 0x3c4ea73ec3b7c65f08a78fecfe226de8d291158eaaa6a8e3028c5b64f988d16a::venko {
    struct VENKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENKO>(arg0, 6, b"VENKO", b"V E N K O", b"ABDUCTING FRIENDS & PETS!  BOUNDLESS UTILITIES  $VENKO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3m_Ekk_L_Lr_400x400_319225920b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VENKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

