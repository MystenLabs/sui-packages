module 0x18db3ce71a4caa53bc43d79f406af9c5336289e90328f5881cff0b4572c1ccd1::sharkwifhat {
    struct SHARKWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKWIFHAT>(arg0, 6, b"SHARKWIFHAT", b"Shark Wif Hat", x"4120736861726b20776974682061206861742e2057686174206d6f726520636f756c6420796f752061736b20666f723f2054686973207375617665207072656461746f72206973207377696d6d696e67207468726f75676820746865205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_27804e404d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

