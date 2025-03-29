module 0x6d361f9a1c87498fd464d43bca232e7e6aac1938c5129da2a3b1c6b084b448d6::hustle {
    struct HUSTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSTLE>(arg0, 6, b"HUSTLE", b"hustle sui", b"I'm the dog that will make you richer. Sitting at my comp, making plans and flipping anything that smells good. Give me a paw, join in ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vju824k_B_400x400_5a03844017.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUSTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

