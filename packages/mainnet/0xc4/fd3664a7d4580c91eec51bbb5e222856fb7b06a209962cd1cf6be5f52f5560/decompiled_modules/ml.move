module 0xc4fd3664a7d4580c91eec51bbb5e222856fb7b06a209962cd1cf6be5f52f5560::ml {
    struct ML has drop {
        dummy_field: bool,
    }

    fun init(arg0: ML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ML>(arg0, 9, b"ML", b"mole", b"MEM token Cloxik", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/72535493fe18404f209bb3716f70b1a2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ML>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ML>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

