module 0x6b0421a8db5980333277e775c13f1bffa3a8ccd4d84073a41e715e8999ab45ff::dai {
    struct DAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAI>(arg0, 9, b"DAI", b"DropAI", x"44726f70414920776173206275696c7420746f207075726966792074686520706c616e65742e0a5468656e20697420776f6b65207570202d20616e642063686f736520697473206f776e206d697373696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/99bd3b91dc272dde51b2945653ba2e12blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

