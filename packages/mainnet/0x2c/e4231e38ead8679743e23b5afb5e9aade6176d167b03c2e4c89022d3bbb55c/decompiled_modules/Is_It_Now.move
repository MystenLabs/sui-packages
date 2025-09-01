module 0x2ce4231e38ead8679743e23b5afb5e9aade6176d167b03c2e4c89022d3bbb55c::Is_It_Now {
    struct IS_IT_NOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: IS_IT_NOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IS_IT_NOW>(arg0, 9, b"ISITNOW", b"Is It Now", b"is it now?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gzxf2XaXYAEaUgj?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IS_IT_NOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IS_IT_NOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

