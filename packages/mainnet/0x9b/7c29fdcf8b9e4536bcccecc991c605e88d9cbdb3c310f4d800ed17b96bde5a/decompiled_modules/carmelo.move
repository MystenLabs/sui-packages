module 0x9b7c29fdcf8b9e4536bcccecc991c605e88d9cbdb3c310f4d800ed17b96bde5a::carmelo {
    struct CARMELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARMELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARMELO>(arg0, 6, b"CARMELO", b"Caramelo Dog Sui", b"Caramelo Dog is a memecoin inspired by the \"caramelo\" dog, a symbol of Brazilian street culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q0_GU_Vmx_Y_400x400_36f19fddf5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARMELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARMELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

