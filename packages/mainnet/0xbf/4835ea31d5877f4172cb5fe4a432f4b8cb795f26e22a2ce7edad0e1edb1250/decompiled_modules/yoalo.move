module 0xbf4835ea31d5877f4172cb5fe4a432f4b8cb795f26e22a2ce7edad0e1edb1250::yoalo {
    struct YOALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOALO>(arg0, 6, b"YOALO", b"The Yolo Guy", x"54686520596f6c6f204775792074687269766573206f6e20626f6c64207269736b732c20626967206c61756768732c20616e642077696c64206d6f6f6e73686f7420647265616d73212020594f4c4f20596f75722057617920746f20746865204d6f6f6e21200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048879_8e1ab8ec2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOALO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

