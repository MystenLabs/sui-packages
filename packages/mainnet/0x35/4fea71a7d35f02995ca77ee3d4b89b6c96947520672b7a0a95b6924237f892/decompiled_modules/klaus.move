module 0x354fea71a7d35f02995ca77ee3d4b89b6c96947520672b7a0a95b6924237f892::klaus {
    struct KLAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLAUS>(arg0, 9, b"KLAUS", b"KLAUS", b"$KLAUS - Little Fish, Big Dream. Riding the wave into the next generation of meme tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KLAUS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLAUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

