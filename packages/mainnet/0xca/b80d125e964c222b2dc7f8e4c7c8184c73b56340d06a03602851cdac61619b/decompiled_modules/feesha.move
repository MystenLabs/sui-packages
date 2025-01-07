module 0xcab80d125e964c222b2dc7f8e4c7c8184c73b56340d06a03602851cdac61619b::feesha {
    struct FEESHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEESHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEESHA>(arg0, 6, b"FEESHA", b"SUIFEESHA", b"I'm Feesha and ready to hit Millys!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Dx_Lk_JE_400x400_5b317355e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEESHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEESHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

