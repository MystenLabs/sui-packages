module 0x44f870848c9c44b967b923b626d63aafcb3f1a2d896f8d6730271a7231c332be::sharkety {
    struct SHARKETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKETY>(arg0, 6, b"SHARKETY", b"SHARKETY SUI", x"534841524b4554592063617074757265732074686520666c656574696e6720617474656e74696f6e207370616e206f6620746865206d61737365732c20656d626f6479696e67207468652073686f72742d7465726d206d656d6f7279206f66206120736861726b6574792e205065726665637420666f72207472656e64206368617365727320616e642073706f6e74616e656f757320646567656e732e20486572652c2073706f6e74616e65697479206973207265776172646564210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_09_at_07_51_50_039a0723e4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKETY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKETY>>(v1);
    }

    // decompiled from Move bytecode v6
}

