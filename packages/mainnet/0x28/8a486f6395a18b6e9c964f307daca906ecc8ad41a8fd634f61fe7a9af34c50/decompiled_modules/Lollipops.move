module 0x288a486f6395a18b6e9c964f307daca906ecc8ad41a8fd634f61fe7a9af34c50::Lollipops {
    struct LOLLIPOPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLLIPOPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LOLLIPOPS>(arg0, 9, b"LOPOPS", b"Lollipop", b"A new regulated coin", 0x1::option::none<0x2::url::Url>(), true, arg1);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LOLLIPOPS>>(0x2::coin::mint<LOLLIPOPS>(&mut v3, 9000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<LOLLIPOPS>>(0x2::coin::mint<LOLLIPOPS>(&mut v3, (4000 as u64), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOLLIPOPS>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::DenyCapV2<LOLLIPOPS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLLIPOPS>>(v2);
    }

    // decompiled from Move bytecode v6
}

