module 0x81c1888730cb7a15c133c544abfb15dbc22c1ae7e8fd1a526e6cf1389aa60d61::bbk {
    struct BBK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBK>(arg0, 6, b"BBK", b"BabyKong Sui", x"5365697a6520746865206461792c20666f637573206f6e20796f752026206f6e6c7920796f752c20697473206120426162794b6f6e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/32c3071a100540554f20c0f2ac1c9089_8ba2c5edbf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBK>>(v1);
    }

    // decompiled from Move bytecode v6
}

