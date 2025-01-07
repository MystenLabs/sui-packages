module 0x70396325c130dfb12b2af5550678838b1527ca0ef11a895f27fb570736acf5eb::fit {
    struct FIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIT>(arg0, 6, b"FIT", b"F It", b"Who cares anymore, F it!  You wanna make something? Go for it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002202_234cc1bf0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

