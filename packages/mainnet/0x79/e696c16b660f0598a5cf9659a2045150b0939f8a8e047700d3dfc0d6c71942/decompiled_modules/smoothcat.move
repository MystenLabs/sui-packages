module 0x79e696c16b660f0598a5cf9659a2045150b0939f8a8e047700d3dfc0d6c71942::smoothcat {
    struct SMOOTHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOOTHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOOTHCAT>(arg0, 6, b"SmoothCat", b"Smooth Cat", x"736d6f6f74682063617420697320746865206f6e6c792063617420746861742063616e206d6f766520736d6f6f74686c79207468726f756768206576657279206d6574612e207768617465766572206368616f73206d617920636f6d652c20736d6f6f7468206361742077696c6c20616c776179732062652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Smooth_Cat_e78eb359d0.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOOTHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOOTHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

