module 0x654ddeb9cd44f2ee6bc75992d3b0188968b61bf09340935233e39b8d90dc2018::badcat {
    struct BADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADCAT>(arg0, 6, b"Badcat", b"badcat", x"416e6479277320416c7465722045676f20617320666561747572656420696e2070616765733a2039352c39372c39382c393920696e20746865426f797320436c756220636f6d69632e0a0a2442414443415420706c6179732061206372756369616c207061727420696e20416e647927732073746f727920666561747572656420696e74686520636f6d696321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731057748406.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BADCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

