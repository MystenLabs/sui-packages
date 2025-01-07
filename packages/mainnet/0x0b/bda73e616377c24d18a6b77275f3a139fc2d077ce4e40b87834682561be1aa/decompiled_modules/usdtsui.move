module 0xbbda73e616377c24d18a6b77275f3a139fc2d077ce4e40b87834682561be1aa::usdtsui {
    struct USDTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTSUI>(arg0, 6, b"USDTSUI", b"USDSUI", x"4e617469766520245553444320686173206f6666696369616c6c79206c61756e63686564206f6e20537569212020576572652070726f756420746f206265207468652066697273742e0a54686973206973206e6f206f7264696e61727920737461626c65636f696e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bui_usdc_886976c7a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

