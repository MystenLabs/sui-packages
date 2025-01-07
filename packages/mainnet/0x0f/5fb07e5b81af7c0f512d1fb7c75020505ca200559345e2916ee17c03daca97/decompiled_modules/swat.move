module 0xf5fb07e5b81af7c0f512d1fb7c75020505ca200559345e2916ee17c03daca97::swat {
    struct SWAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAT>(arg0, 9, b"SWAT", b"SWAT", b"SWAT TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWAT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

