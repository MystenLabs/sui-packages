module 0x509a61a35900a413f6715c7c38e2631da7cc1e3031fb3e1c949d092d60cc7cf4::billy {
    struct BILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLY>(arg0, 6, b"BILLY", b"BILLY ON SUI", x"42696c6c79206973207468652063757465737420707570707920696e207468652077686f6c6520776f726c6420616e64206973206e6f7720636f6d696e6720746f2053554921210a0a42696c6c792077616e747320746f2073686172652068697320637574656e657373207769746820616c6c2063727970746f2066616e7320616e6420444547454e53210a0a42696c6c79206861732074616b656e206f76657220534f4c206275742063616e20796f752068656c702068696d2074616b65206f766572205355492121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/billy_3adaa09047.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

