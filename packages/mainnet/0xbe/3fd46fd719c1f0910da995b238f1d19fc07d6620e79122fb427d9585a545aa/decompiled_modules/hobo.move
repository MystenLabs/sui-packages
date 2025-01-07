module 0xbe3fd46fd719c1f0910da995b238f1d19fc07d6620e79122fb427d9585a545aa::hobo {
    struct HOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOBO>(arg0, 6, b"HOBO", b"Hold On Books Off", b"HOBO now on SUI Officially.. Lets Pump It...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_JEN_Rp_K_400x400_bc77b8ee45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

