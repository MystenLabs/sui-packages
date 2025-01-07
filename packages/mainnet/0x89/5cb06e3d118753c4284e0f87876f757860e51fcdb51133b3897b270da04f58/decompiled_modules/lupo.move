module 0x895cb06e3d118753c4284e0f87876f757860e51fcdb51133b3897b270da04f58::lupo {
    struct LUPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUPO>(arg0, 6, b"Lupo", b"SUI Lupo", b"$lupo for the cult", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilupo_4784fe07b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

