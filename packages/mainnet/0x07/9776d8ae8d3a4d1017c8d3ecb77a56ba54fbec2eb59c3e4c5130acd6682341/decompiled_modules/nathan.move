module 0x79776d8ae8d3a4d1017c8d3ecb77a56ba54fbec2eb59c3e4c5130acd6682341::nathan {
    struct NATHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NATHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NATHAN>(arg0, 9, b"NATHAN", b"NATHAN", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NATHAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NATHAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NATHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

