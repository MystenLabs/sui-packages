module 0x893b2260bd412e259a7b26c9a4a3b07c3a06bbfac20a43105c29e82ec3d6476b::lilmoew {
    struct LILMOEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILMOEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILMOEW>(arg0, 6, b"LILMOEW", b"LIL MEOW", x"205468652070657266656374206d656d6520636f696e2e204a6f696e20746865206c697474657220616e64206c657473206765742066656c696e65207269636821204a6f696e207573200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_05_32_48_6346df134d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILMOEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILMOEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

