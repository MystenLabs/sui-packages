module 0xdc0f5902acced3e4a3e225e423566a01942529ac5647cc74bf190b555505e328::dvs_mvhnxn0u {
    struct DVS_MVHNXN0U has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVHNXN0U, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVHNXN0U>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvhnxn0u"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVHNXN0U>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVHNXN0U>>(0x2::coin_registry::finalize<DVS_MVHNXN0U>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

