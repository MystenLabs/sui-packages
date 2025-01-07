module 0x97bb2efd9e10d886e610bed076ebbf26ebe306a7b558f44a73c7de8454382581::lords {
    struct LORDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORDS>(arg0, 7, b"lords", b"suilords", b"Suilords the degen cult", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LORDS>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORDS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

