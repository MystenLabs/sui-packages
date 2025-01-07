module 0x5710fafbd7a7b79b2d96417d58a0de5e6cc87075be031ea2acdc16aad830e02f::ponked {
    struct PONKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKED>(arg0, 9, b"PONKED", b"PONKED", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONKED>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

