module 0x30715bb701977bd685d2182a884f73914424bc89249e0e609793f4114e569f8a::luga_ {
    struct LUGA_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGA_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUGA_>(arg0, 9, b"LUGA", x"f09f8ea04c756761", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUGA_>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUGA_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUGA_>>(v1);
    }

    // decompiled from Move bytecode v6
}

