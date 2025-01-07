module 0x8fea166c25a01a94d5f6925a3abfc0391248b2679a7ed395bea77c0669b76958::inu {
    struct INU has drop {
        dummy_field: bool,
    }

    fun init(arg0: INU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INU>(arg0, 6, b"Inu", b"SuiInu", b"https://t.me/suisinu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hello_5aaa54fd2b.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INU>>(v1);
    }

    // decompiled from Move bytecode v6
}

