module 0xa309d5a6825d1a7a94391e028ec5ebf2b5c24a0380fa428e6711b8b04425a399::breaddog {
    struct BREADDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREADDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREADDOG>(arg0, 6, b"BREADDOG", b"BreadDog", b"justice for the bread Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Em_Mgc_Z8_XIAAJEVB_f86b055338.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREADDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREADDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

