module 0x81a0263f2d012a7c8845c043d5895b15553d3be450053074cb40b0c01fc227f2::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 6, b"SUID", b"SuiSage Dog", x"5375697361676520446f67202d2057696c6c20626520746865206269676765737420436f696e206f6e20537569204e6574776f726b2e0a204d69737365642053686962612050756d703f204c6173742043616c6c20466f72205375697361676520446f6721210a203130204d696c20496e636f6d696e672053756973616765204761696e73200a536f6f6e203530306b2b20566f6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004307_47ad9838aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

