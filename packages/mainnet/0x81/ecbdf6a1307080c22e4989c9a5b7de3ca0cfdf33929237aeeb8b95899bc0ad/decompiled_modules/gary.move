module 0x81ecbdf6a1307080c22e4989c9a5b7de3ca0cfdf33929237aeeb8b95899bc0ad::gary {
    struct GARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARY>(arg0, 6, b"GARY", b"GARY SUI", b"Onboarding web2 creators to crypto with a Solana creator coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J_Wzw0_A_Dk_400x400_f49256c67f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

