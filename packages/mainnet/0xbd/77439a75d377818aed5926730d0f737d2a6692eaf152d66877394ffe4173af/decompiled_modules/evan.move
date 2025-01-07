module 0xbd77439a75d377818aed5926730d0f737d2a6692eaf152d66877394ffe4173af::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVAN>(arg0, 9, b"EVAN", x"f09f9fa64556414e204348454e47", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EVAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

