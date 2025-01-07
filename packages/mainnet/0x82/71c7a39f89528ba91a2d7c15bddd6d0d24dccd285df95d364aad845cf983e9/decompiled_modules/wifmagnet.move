module 0x8271c7a39f89528ba91a2d7c15bddd6d0d24dccd285df95d364aad845cf983e9::wifmagnet {
    struct WIFMAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFMAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFMAGNET>(arg0, 6, b"WIFMAGNET", b"DOGWIF MAGNET", b"BLUE DOG WIF MAGNET ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/639113_FA_BCEB_4_E12_A572_E3_C3_F8362_CAE_ce94989f26.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFMAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFMAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

