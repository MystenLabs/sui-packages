module 0x48d0c671cc461a9fc73f35db02556b1bb7f634af02292a7e07504b2fa5c13383::lumi {
    struct LUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMI>(arg0, 6, b"LUMI", b"Lumi sui", b"What happens when LUMI appears? All other MEMES fade into the background! Forget about dogs and frogs, it's all about AI and LUMI now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067965_c48cf3c417.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

