module 0x2980f9a5fb6132e6d0942a9ef4b4a89aa87c9bc40e7b14b45a6ceca2438d9a8b::suipogai {
    struct SUIPOGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOGAI>(arg0, 6, b"SuiPogai", b"pogai", b"POGAI is a new token based on the Sui blockchain, which aims to provide users with more possibilities through efficient and secure transaction experience. POGAI combines the innovation of blockchain technology with the concept of decentralization, bringing lower transaction costs and faster transaction speeds. Whether it is used for payment, transactions, or future decentralized applications (DApp), POGAI will become a force that cannot be ignored on the Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240912221528_c37faa6a7d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPOGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

