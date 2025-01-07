module 0x84e4cda9b3c042a484421d81336fe24c750b29db0a897294e892bc3b12f31619::dev {
    struct DEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV>(arg0, 6, b"DEV", b"DEV IS DEVVING", x"224465762069732064657676696e672c22206265636f6d657320612072616c6c79696e672063727920666f72206465767320746f206b656570206275696c64696e672c20636f64696e672c20616e64206372656174696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_01_16_55_9d5d3ddd6b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

