module 0x738b400f7dae1565735fa54f21a93108fc00a738d61f3385f45f0489a19d9315::suipe {
    struct SUIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPE>(arg0, 9, b"SUIPE", b"SUIPE", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

