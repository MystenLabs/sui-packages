module 0xbc6f4e6df4aab1e02785f1acf3154725f21001290f010895db6c86c68cd7077f::loafcat {
    struct LOAFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOAFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOAFCAT>(arg0, 6, b"LOAFCAT", b"LOAF CAT SUI", b"LOAF CAT SUI IS THE MEME CAT ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_Ih_Iyq7g_400x400_5e05fdf855.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOAFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOAFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

