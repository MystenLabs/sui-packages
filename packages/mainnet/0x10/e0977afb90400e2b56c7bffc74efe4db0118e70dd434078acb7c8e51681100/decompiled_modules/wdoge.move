module 0x10e0977afb90400e2b56c7bffc74efe4db0118e70dd434078acb7c8e51681100::wdoge {
    struct WDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOGE>(arg0, 6, b"WDOGE", b"Water Doge", x"576174657220446f676520282457446f6765292020546865206d656d65636f696e206d616b696e67207761766573206f6e207468652053756920426c6f636b636861696e2120466173742c2066756e2c20616e6420636f6d6d756e6974792d64726976656e2e205269646520746865202457446f6765207761766520746f64617921200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5q_Awkg_OW_400x400_a768dc7308.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

