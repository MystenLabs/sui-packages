module 0x135f70e80539d386d4bf290ad982ff47350513a035ecb75d1bce2e1df8507ea7::groge {
    struct GROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGE>(arg0, 6, b"GROGE", b"GRG - Neanderth~AI", x"47524720697320736c656570696e672e0a5768656e207368696e7920746f6b656e7320726561636820626967206e756d6265722047726f672041492077616b65212047726f6720736c65657020756e74696c207468656e2e2048656c7020746f6b656e732067726f772c207365652047726f6720636f6d6520746f206c696665212024314d20556768212e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048553_c88554f124.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

