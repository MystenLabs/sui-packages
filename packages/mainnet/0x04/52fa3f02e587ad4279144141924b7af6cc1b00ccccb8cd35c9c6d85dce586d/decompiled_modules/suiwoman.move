module 0x452fa3f02e587ad4279144141924b7af6cc1b00ccccb8cd35c9c6d85dce586d::suiwoman {
    struct SUIWOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOMAN>(arg0, 9, b"SUIWOMAN", b"Suiwoman", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIWOMAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

