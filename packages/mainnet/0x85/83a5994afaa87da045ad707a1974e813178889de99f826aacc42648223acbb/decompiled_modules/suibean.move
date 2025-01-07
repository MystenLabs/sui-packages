module 0x8583a5994afaa87da045ad707a1974e813178889de99f826aacc42648223acbb::suibean {
    struct SUIBEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEAN>(arg0, 9, b"SUIBEAN", b"Sui Bean", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBEAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

