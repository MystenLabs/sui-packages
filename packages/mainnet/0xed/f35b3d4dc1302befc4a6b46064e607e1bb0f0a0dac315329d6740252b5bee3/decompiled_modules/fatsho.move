module 0xedf35b3d4dc1302befc4a6b46064e607e1bb0f0a0dac315329d6740252b5bee3::fatsho {
    struct FATSHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATSHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATSHO>(arg0, 6, b"FATSHO", b"Rare piece", x"546865206f6e6c792067616d65200a20746861742773206c697665207269676874206e6f772e0a20746f20706c617920616e64206a6f696e20746865206c6561646572626f6172642c20616e64206576656e7475616c6c79206561726e202446415453484f2e0a0a57696c6c20796f752062652061206368616d70696f6e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1066eaf1cb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATSHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATSHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

