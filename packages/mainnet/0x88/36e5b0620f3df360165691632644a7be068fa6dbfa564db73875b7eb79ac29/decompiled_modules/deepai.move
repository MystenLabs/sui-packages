module 0x8836e5b0620f3df360165691632644a7be068fa6dbfa564db73875b7eb79ac29::deepai {
    struct DEEPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPAI>(arg0, 6, b"DEEPAI", b"DeepAI", x"4576657220776f6e646572656420696620796f757220414920696e666c75656e63657220636f756c64206d616b6520796f75206d6f6e65793f200a0a57697468204445455041492c20796f7520646f6e740a6a7573742063726561746520796f7572206f776e20696e666c75656e636572732c20796f750a756e6c6f636b206e657720726576656e75652073747265616d732e200a0a414920696e666c75656e636572206d61726b6574696e6720697320726573686170696e67207468652067616d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250124_134432_438_d4f5e72385.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

