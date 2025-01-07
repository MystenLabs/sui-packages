module 0x664c061e7d58417d61d9cab1c1aa7cfcd2e2c50adf7a280c9f5abc2a8faa85e1::suitans {
    struct SUITANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITANS>(arg0, 6, b"SUITANS", b"Suitans Of Swing", x"596f752067657420612073686976657220696e20746865206461726b0a497427732061207261696e696e6720696e20746865207061726b20627574206d65616e74696d652d0a536f757468206f662074686520726976657220796f752073746f7020616e6420796f7520686f6c642065766572797468696e670a412062616e6420697320626c6f77696e672044697869652c20646f75626c6520666f75722074696d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artworks_2t_Ms_Mn_US_Bl0nn_Fs_G_2_Sz_OPA_t500x500_7e45d7fa7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

