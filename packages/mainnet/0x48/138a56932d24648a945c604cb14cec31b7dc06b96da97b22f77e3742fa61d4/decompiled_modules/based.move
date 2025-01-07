module 0x48138a56932d24648a945c604cb14cec31b7dc06b96da97b22f77e3742fa61d4::based {
    struct BASED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASED>(arg0, 6, b"BASED", b"XrpTrump69dOgeBoden420", b"The first $BASED narrative on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0544_0f57e268e2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASED>>(v1);
    }

    // decompiled from Move bytecode v6
}

