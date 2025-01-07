module 0x5a78ca6111fe012d114f027635ae337f05056d39be12a332faa51dcf8d11dff4::bima {
    struct BIMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIMA>(arg0, 6, b"BIMA", b"Bima", b"$BIMA is a lovable cartoon cat and the loyal companion of Pepe the Frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kup_Axb_Rf_400x400_0f5359e493.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

