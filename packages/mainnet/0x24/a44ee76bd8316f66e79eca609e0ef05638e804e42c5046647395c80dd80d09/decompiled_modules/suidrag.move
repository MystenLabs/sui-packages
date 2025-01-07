module 0x24a44ee76bd8316f66e79eca609e0ef05638e804e42c5046647395c80dd80d09::suidrag {
    struct SUIDRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDRAG>(arg0, 6, b"SUIDRAG", b"SUIDRAGON", x"464952535420537569447261676f6e206f6e20535549210a706f73743a2068747470733a2f2f782e636f6d2f426974636f696e2f7374617475732f31383434343732353334323930353330333732", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_00_02_35_ab8f86d7ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDRAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDRAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

