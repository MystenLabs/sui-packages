module 0x97bf9a3af4c7b497cd5b70ebdf33715921383e279722119854230a495870df1::rebel {
    struct REBEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REBEL>(arg0, 6, b"REBEL", b"Rebel the dog", x"4a6f696e2074686520726562656c6c696f6e20616761696e73742074686520636162616c210a0a457665727964617920696e20746865207472656e6368657320616e642067657474696e672072656b6b742066726f6d2074686520636162616c732c2069747320656e6f7567682120524542454c206973207374617274696e67206120726562656c6c696f6e20616761696e7374207468656d21204a6f696e207468652063756c7420616e6420776520666967687420746f6765746865722e204d61736b206f6e2c20636162616c206f666621", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048977_a228f39e04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REBEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REBEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

