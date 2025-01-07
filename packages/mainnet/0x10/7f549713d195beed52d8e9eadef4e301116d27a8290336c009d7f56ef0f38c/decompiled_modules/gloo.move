module 0x107f549713d195beed52d8e9eadef4e301116d27a8290336c009d7f56ef0f38c::gloo {
    struct GLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOO>(arg0, 6, b"Gloo", b"SUIGLOO", x"24537569676c6f6f20697320746865206d6f73742061646f7261626c65206d656d65636f696e206f6e205355490a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241014_203214_140_17846e798e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

