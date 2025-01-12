module 0xc21095a253df10d33aec9280de8fdfb7f88f1036cbda8a46f17f34d80ebb907f::lizzy {
    struct LIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIZZY>(arg0, 6, b"LIZZY", b"Lizzy On Sui", x"244c697a7a7920697320746865206765636b6f2d696e737069726564206d656d65636f696e206272696e67696e67206167696c69747920616e6420636861726d20746f207468652063727970746f20776f726b20636c696d62696e6720746f2074686520746f702c206f6e65206c65617020617420612074696d65210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z2_W04pf_G_400x400_a7ef2518fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

