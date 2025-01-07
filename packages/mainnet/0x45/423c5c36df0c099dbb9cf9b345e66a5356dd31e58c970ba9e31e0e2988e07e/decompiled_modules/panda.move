module 0x45423c5c36df0c099dbb9cf9b345e66a5356dd31e58c970ba9e31e0e2988e07e::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"PANDA", b"Panda", b"A community composed of a group of panda-loving partners. Partners who want to buy tokens, please join the group chat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_L_Gk_A_Kn_H_400x400_ecaab5224b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

