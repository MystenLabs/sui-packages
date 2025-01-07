module 0xaced7c8ed407d1a6281485ea9446eea6c4355055659fa611da7d6ee3b371af99::big {
    struct BIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG>(arg0, 9, b"BIG", b"Biglovedap", x"426c6f7665204461707020697320616e20656e7465727461696e6d656e7420544150206170706c69636174696f6e2074686174206561726e732061697264726f70206d6f6e657920696e7374656164206f662074656c656772616d20626563617573652074656c656772616d207374696c6c20686173206d616e79206c696d69746174696f6e73f09f8f86f09f8c9f2e0a436f64653a206f6e6e6c6f64796e6e6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce389a02-4a24-4761-99cc-4cac70694e71.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

