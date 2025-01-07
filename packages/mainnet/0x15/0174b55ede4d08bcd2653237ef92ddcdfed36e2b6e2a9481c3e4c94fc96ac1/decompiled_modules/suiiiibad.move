module 0x150174b55ede4d08bcd2653237ef92ddcdfed36e2b6e2a9481c3e4c94fc96ac1::suiiiibad {
    struct SUIIIIBAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIIBAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIIBAD>(arg0, 9, b"SUIIIIBAD", b"SUIIIIBAD", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIIIIBAD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIIBAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIIBAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

