module 0x8ddee769571d51c8bc16fab686573cc883157f5aaf55085bb0e8406a141aa21d::chi {
    struct CHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHI>(arg0, 6, b"Chi", b"ChiChii", b"Discover your place in the SUI universe. Your key to unlocking the thriving SUI ecosystem and all its hidden treasures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_Y_Zs1q_Ef_400x400_f66506b38f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

