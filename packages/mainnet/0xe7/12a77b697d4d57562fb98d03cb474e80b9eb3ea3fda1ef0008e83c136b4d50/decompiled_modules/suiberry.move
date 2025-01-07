module 0xe712a77b697d4d57562fb98d03cb474e80b9eb3ea3fda1ef0008e83c136b4d50::suiberry {
    struct SUIBERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBERRY>(arg0, 6, b"SuiBerry", b"Sui Berry", b"What description do you need of a blue berry this is gold!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diseno_sin_titulo_2_4efb50009c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

