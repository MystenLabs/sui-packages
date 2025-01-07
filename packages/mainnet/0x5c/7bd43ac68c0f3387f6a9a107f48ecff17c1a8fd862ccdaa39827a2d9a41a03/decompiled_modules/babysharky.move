module 0x5c7bd43ac68c0f3387f6a9a107f48ecff17c1a8fd862ccdaa39827a2d9a41a03::babysharky {
    struct BABYSHARKY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABYSHARKY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BABYSHARKY>>(0x2::coin::mint<BABYSHARKY>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: BABYSHARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSHARKY>(arg0, 9, b"SHARKY", b"BABYSHARKY", b"Baby Sharky cute little shark with cool TG stickers and NFTs a utility token to use for payments for the NFTs or stickers by purchasing with SHARKY you get 20 percent discount.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1786648856454971392/2d00b2WL_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYSHARKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYSHARKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSHARKY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

