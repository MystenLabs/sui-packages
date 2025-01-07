module 0x15572177a81d5e6868797ddc35ad26d7a50fded8045a470e54c29c13e2e14d02::babyrussell {
    struct BABYRUSSELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYRUSSELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYRUSSELL>(arg0, 6, b"BABYRUSSELL", b"Baby Russell", x"41206e6577206164646974696f6e20746f207468652041726d7374726f6e672066616d696c79206861732061727269766564210a426162792052757373656c6c20686173206265656e206e65776c7920626f726e20697320726561647920746f20666f6c6c6f7720686973206461647320666f6f74737465707320746f206d696c6c696f6e73210a313025206f6620737570706c7920686173206265656e2073656e7420746f204a6573736520506f6c6c616b27732077616c6c6574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RG_37y_Rmq_400x400_71aa2468ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYRUSSELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYRUSSELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

