module 0x12d2ae7dcb61148f8f99cffb32dbdb3b6ceec69fb9b381f767bf0deb910d6161::meny {
    struct MENY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENY>(arg0, 6, b"MENY", b"Sui Meny", b"$MENY: The legendary leader of the crypto community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021596_3b63efcf66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MENY>>(v1);
    }

    // decompiled from Move bytecode v6
}

