module 0x2f77808fe7ca1917eb83b70f5871299b636da29ec1b5d0d1f1982786c7065c9f::bluepug {
    struct BLUEPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEPUG>(arg0, 6, b"BLUEPUG", b"BLUE PUGGY", x"505547475920746865206d656d65636f696e20666f722065766572796f6e6521204a6f696e20612076696272616e7420636f6d6d756e6974792064726976656e206279206861726420776f726b20616e642068756d6f7220617320776520656d6261726b206f6e20612066756e2d66696c6c6564207269646520746f20746865206d6f6f6e20616e64206265796f6e642e204275636b6c652075702c20656d627261636520746865206c61756768732c20616e64206c657473206d616b652074686973206a6f75726e657920756e666f726765747461626c6520746f67657468657221202023507567677946616d696c790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4015_193f78d122.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

