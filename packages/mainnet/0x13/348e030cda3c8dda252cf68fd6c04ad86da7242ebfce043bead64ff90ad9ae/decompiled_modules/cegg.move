module 0x13348e030cda3c8dda252cf68fd6c04ad86da7242ebfce043bead64ff90ad9ae::cegg {
    struct CEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEGG>(arg0, 6, b"CEGG", b"Chick Egg", x"436869636b456767206973206120736d616c6c2c20717569726b7920636869636b207374696c6c2068616c6620737475636b20696e20697473207368656c6c206275740a656167657220746f206578706c6f72652074686520776f726c642e2046726f6d206c6974746c65207374756d626c657320746f20736d616c6c0a766963746f726965732c20436869636b4567672070726f7665732074686174206576656e2074686520736d616c6c6573742073746570732063616e206c6561640a746f2062696720616476656e74757265732e20466f6c6c6f7720746865206a6f75726e657920666f7220736f6d65206c617567687320616e642066756e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004126_6e0c470117.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

