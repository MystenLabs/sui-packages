module 0x7ccf4d21be43bdfd1345c9adf88c7deedb17b30cb6e2598b3ac418d53109901b::bluedog {
    struct BLUEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDOG>(arg0, 6, b"BLUEDOG", b"BLUE DOG", b"BLUE DOG SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/42_A79_B1_A_FEAC_4_E09_8_EB_5_138780324_B27_8bdafec440.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

