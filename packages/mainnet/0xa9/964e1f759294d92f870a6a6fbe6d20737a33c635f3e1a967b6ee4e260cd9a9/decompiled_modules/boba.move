module 0xa9964e1f759294d92f870a6a6fbe6d20737a33c635f3e1a967b6ee4e260cd9a9::boba {
    struct BOBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBA>(arg0, 9, b"BOBA", b"BOBA", b"BOBA on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOBA>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

