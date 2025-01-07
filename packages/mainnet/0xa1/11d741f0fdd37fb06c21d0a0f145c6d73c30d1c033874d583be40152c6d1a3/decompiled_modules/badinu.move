module 0xa111d741f0fdd37fb06c21d0a0f145c6d73c30d1c033874d583be40152c6d1a3::badinu {
    struct BADINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADINU>(arg0, 6, b"BADINU", b"Bad Inu On Sui", b"To get on his good side, show Bad Inu that you are a primate and not a pussy cat. Then he will respect you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q_A5omq_E_400x400_removebg_preview_d711590e45.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

