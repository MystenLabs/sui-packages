module 0x48c9c6170030a966a9eaa86e1fe90b85f4e7a9f41f990d00f59491c858fbc27a::mac {
    struct MAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAC>(arg0, 6, b"Mac", b"Macorner", x"4d61636f726e657220204d656d6520546f6b656e20506172746e65726564207769746820504f442053746f72653a2041204e657720427265616b7468726f75676820696e20746865204d656d6520436f696e20576f726c640a4d61636f726e6572206973206120756e69717565206d656d6520746f6b656e20626f726e2066726f6d206120637265617469766520636f6c6c61626f726174696f6e207769746820746865205072696e74204f6e2044656d616e642028504f442920627573696e657373206d6f64656c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mac_0a03ea5c53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

