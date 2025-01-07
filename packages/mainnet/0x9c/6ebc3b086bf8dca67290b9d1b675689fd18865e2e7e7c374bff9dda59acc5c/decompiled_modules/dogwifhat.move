module 0x9c6ebc3b086bf8dca67290b9d1b675689fd18865e2e7e7c374bff9dda59acc5c::dogwifhat {
    struct DOGWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFHAT>(arg0, 6, b"DOGWIFHAT", b"DOG WIF HAT", b"DOG WIF HAT SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_B3_D6244_99_D1_4847_919_C_C536_E71_C7_FB_9_b5e2778788.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

