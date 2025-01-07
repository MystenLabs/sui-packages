module 0x6dff3e9f4373a8c5904f4a0de90d5de4949e365796699f1c9addf878c8a0446d::yfu {
    struct YFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YFU>(arg0, 6, b"YFU", b"Waifu On Sui", x"417369616e207769766573206172652074686520416c7068612e0a0a5573686572696e6720696e20746865206e65772077617665206f6620496e7465726e65742043756c7475726520546f6b656e732c206f6e6c79206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731170512623.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YFU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YFU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

