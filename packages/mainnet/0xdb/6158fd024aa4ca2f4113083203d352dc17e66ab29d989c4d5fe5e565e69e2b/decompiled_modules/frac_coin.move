module 0x1f015c1a000631f2c0afd0258b299c63ffb8e5452e0c0f9be8fc28d2e20ad9b4::frac_coin {
    struct FRAC_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRAC_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::vault::CreateVaultCap<FRAC_COIN>>(0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::interface::create_fractionalized_coin<FRAC_COIN>(arg0, 9, b"GenHc", b"Sui Generis HC", b"Fractionalized Coin used to upgrade Sui Generis House Collection NFTs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suigeneris.auction/icon.png")), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

