module 0x1894901676ff0f0153c4be752fdb7f42879ab4ab7313a06d1f52edb9c0b4165f::suicard {
    struct SUICARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICARD>(arg0, 6, b"SuiCard", b"Sui Card", x"42656c6965766520696e20736f6d657468696e670a42656c6965766520696e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_card_b7eb3841ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

