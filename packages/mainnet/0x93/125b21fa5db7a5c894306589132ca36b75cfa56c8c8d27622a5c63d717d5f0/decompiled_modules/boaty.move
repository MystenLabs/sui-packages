module 0x93125b21fa5db7a5c894306589132ca36b75cfa56c8c8d27622a5c63d717d5f0::boaty {
    struct BOATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOATY>(arg0, 6, b"BOATY", b"Boaty McBoatface", b"Share the journey with Boaty McBoatface as it sets sail to ride the waves of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Boaty_NB_Master_Low_Res_c8acd952e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOATY>>(v1);
    }

    // decompiled from Move bytecode v6
}

