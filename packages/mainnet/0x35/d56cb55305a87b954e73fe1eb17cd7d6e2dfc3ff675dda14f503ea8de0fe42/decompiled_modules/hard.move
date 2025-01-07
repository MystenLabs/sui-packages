module 0x35d56cb55305a87b954e73fe1eb17cd7d6e2dfc3ff675dda14f503ea8de0fe42::hard {
    struct HARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARD>(arg0, 6, b"Hard", b"hard images", x"6861726420696d61676573206f6e207375690a0a6861726420696d6167657320697320612066616d6f757320696e7465726e6574206d656d65200a6861726420696d61676573206765742068756e647265642074686f7573616e6473206f66206c696b657320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/knockout_88f1a43465.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

