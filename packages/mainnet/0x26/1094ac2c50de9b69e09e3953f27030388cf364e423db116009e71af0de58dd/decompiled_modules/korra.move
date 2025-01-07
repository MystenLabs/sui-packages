module 0x261094ac2c50de9b69e09e3953f27030388cf364e423db116009e71af0de58dd::korra {
    struct KORRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KORRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KORRA>(arg0, 6, b"KORRA", b"Korra on Sui", b"Korra is here to make the Sui chain rise!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_12_20_at_12_25_09_df13c60a_10d74d873d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KORRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KORRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

