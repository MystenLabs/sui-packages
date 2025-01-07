module 0xafbf44597a50b0ed7d966312a6898fe9dc54dc62b18664f449549fb9ea2921b1::suifox {
    struct SUIFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFOX>(arg0, 6, b"SuiFox", b"Bill", x"42696c6c696f6e7320676f74202462696c6c20696e2069742c20616e6420796f757265207374696c6c207468696e6b696e67206f6620666164696e67202462696c6c3f200a0a5768696c65204d6574616d61736b20776f6e74206265206c61756e6368696e6720697473206f776e20746f6b656e2c202462696c6c206973206261736963616c6c792074686520756e6f6666696369616c204d6574616d61736b20746f6b656e206e6f7721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20_6c19750562.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

