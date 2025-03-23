module 0x2ecdfb086603fc9b9a383a01da20e9113084eb8a7ae1e27359f4f36c5d06d225::suicard {
    struct SUICARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICARD>(arg0, 6, b"SuiCard", b"Sui Card", x"42656c6965766520696e20736f6d657468696e670a42656c6965766520696e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_card_e84055c7a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

