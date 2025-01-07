module 0xe7c0d508d87696d1fef982dfd27a9f9a9d150b822676e2358b7c184893d2b280::pot {
    struct POT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POT>(arg0, 6, b"POT", b"PotWorldGame", x"506f74576f726c6447616d65206973206120636f6d6d756e6974792d64726976656e20446546692070726f6a65637420636f6d62696e696e67207374616b696e672c20726577617264732c20616e64206120756e69717565204e465420636f6c6c656374696f6e2e200a68747470733a2f2f6769746875622e636f6d2f506f74576f726c6447616d650a68747470733a2f2f7777772e696e7374616772616d2e636f6d2f706f74776f726c6467616d652f0a68747470733a2f2f646973636f72642e636f6d2f696e766974652f77593744623857555157", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726836107023_0ecc5775f238d194dc61090133a75239_d60f645b03.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POT>>(v1);
    }

    // decompiled from Move bytecode v6
}

