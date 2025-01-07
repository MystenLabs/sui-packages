module 0xe307679703075dbb5a40f8f4925f45eda7597bc5fd329846989a0cf331e26c::pooky {
    struct POOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOKY>(arg0, 9, b"POOKY", b"POOKY", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POOKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

