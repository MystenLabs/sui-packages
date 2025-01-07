module 0xee894807607c5e8bf3e188d8127c7f6b7793a69eb0bc35d553d095a0b8a458b9::neighbor {
    struct NEIGHBOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIGHBOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIGHBOR>(arg0, 6, b"NEIGHBOR", b"NEIGHBOR BORIS", x"0a57686f206973204e65696768626f7220426f7269733f0a426f72697320206973206120756e6971756520616e64207068696c616e7468726f70696320696e646976696475616c206c6976696e6720696e20746865206166666c75656e74206e65696768626f72686f6f64206f660a0a4d656d6576696c6c652c20737572726f756e64656420627920616e20656363656e7472696320636f6d6d756e697479206f6620636861726163746572732066726f6d20696e7465726e6574206d656d652063756c747572652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RCX_26rp_D_400x400_d21182a748.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIGHBOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIGHBOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

