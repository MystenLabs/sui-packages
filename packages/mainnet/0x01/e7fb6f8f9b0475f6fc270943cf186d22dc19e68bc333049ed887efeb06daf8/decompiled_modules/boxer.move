module 0x1e7fb6f8f9b0475f6fc270943cf186d22dc19e68bc333049ed887efeb06daf8::boxer {
    struct BOXER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOXER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOXER>(arg0, 6, b"Boxer", b"SUIBoxer", b"SUI said f*** off, but we say welcome/ LP locked & mint immutable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/boxer_eceb5dc925.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOXER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOXER>>(v1);
    }

    // decompiled from Move bytecode v6
}

