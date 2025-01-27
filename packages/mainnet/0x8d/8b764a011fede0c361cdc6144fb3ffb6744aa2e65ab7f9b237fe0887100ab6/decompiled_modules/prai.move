module 0x8d8b764a011fede0c361cdc6144fb3ffb6744aa2e65ab7f9b237fe0887100ab6::prai {
    struct PRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRAI>(arg0, 6, b"PRAI", b"PetRockAI", b"Introducing the world's first 100% Accurate AI Model. Our user friendly interface handles any prompt instantaneously with life-like accuracy. PetRockAI offers unparalleled user experience with a core focus on realism.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/petrock_A_Icrop_b54f2fa2d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

