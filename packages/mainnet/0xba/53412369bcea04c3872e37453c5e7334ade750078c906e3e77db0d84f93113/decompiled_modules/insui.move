module 0xba53412369bcea04c3872e37453c5e7334ade750078c906e3e77db0d84f93113::insui {
    struct INSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSUI>(arg0, 6, b"InSui", b"inSUIne", x"746f6b656e20666f722074686f73652077686f2068617665206265656e20676f696e6720696e73616e65206c6174656c790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750198763565.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

