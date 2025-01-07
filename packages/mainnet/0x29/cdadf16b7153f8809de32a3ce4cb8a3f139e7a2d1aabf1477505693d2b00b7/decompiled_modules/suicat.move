module 0x29cdadf16b7153f8809de32a3ce4cb8a3f139e7a2d1aabf1477505693d2b00b7::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"SUI CAT", x"546865206f726967696e616c206361742d7468656d6564206d656d6520636f696e206f6e207468652053756920626c6f636b636861696e2120417320746865206669727374206f6620697473206b696e642c205768656e20697420636f6d657320746f2063617420636f696e73206f6e205375692c20776572652074686520747261696c626c617a6572732073657474696e6720746865207472656e642e2047657420696e206f6e207468652067726f756e6420666c6f6f722077697468205375692043617420616e642062652070617274206f6620746865204f472063617420636f696e207265766f6c7574696f6e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_and_photos_01_812caab3d3_b4060e8a4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

