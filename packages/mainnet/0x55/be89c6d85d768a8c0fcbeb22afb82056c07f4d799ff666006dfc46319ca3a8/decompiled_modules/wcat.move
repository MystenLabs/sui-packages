module 0x55be89c6d85d768a8c0fcbeb22afb82056c07f4d799ff666006dfc46319ca3a8::wcat {
    struct WCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAT>(arg0, 6, b"wCAT", b"Water Cat", x"43617420696e2077617465722e200a0a4e6f20736f6369616c732e20497427732061206361742e20496e207468652053756920776174657273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001140_031b4f510c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

