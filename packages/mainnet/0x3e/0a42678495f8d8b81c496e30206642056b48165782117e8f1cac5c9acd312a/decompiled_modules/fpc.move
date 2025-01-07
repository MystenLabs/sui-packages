module 0x3e0a42678495f8d8b81c496e30206642056b48165782117e8f1cac5c9acd312a::fpc {
    struct FPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPC>(arg0, 6, b"FPC", b"Frenchie", x"4672656e636869652069732061204672656e636820507265737320436f666665652e200a0a4d616b6520796f757220636f6666656520617420686f6d652c2073617665206d6f6e65792c20616e642062757920736f6d65204672656e636869652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/french_press_94bc71755f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

