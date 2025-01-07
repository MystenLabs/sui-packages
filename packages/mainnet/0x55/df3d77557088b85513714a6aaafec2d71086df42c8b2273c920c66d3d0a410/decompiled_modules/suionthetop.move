module 0x55df3d77557088b85513714a6aaafec2d71086df42c8b2273c920c66d3d0a410::suionthetop {
    struct SUIONTHETOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIONTHETOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIONTHETOP>(arg0, 9, b"SUIONTHETOP", b"SUI on the top", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIONTHETOP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIONTHETOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIONTHETOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

