module 0x61faec40d1709cbe3440d73ecee4afcc8d055ccdc63ff3d264fa129649e722d2::gecko {
    struct GECKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECKO>(arg0, 6, b"GECKO", b"Geckos on Sui", b"the official token of the gecko ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QYX_Ic_Ur_U_400x400_94ce6b9982.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GECKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

