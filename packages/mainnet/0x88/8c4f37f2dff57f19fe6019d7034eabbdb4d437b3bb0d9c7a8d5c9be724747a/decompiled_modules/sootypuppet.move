module 0x888c4f37f2dff57f19fe6019d7034eabbdb4d437b3bb0d9c7a8d5c9be724747a::sootypuppet {
    struct SOOTYPUPPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOTYPUPPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOTYPUPPET>(arg0, 6, b"Sootypuppet", b"Sooty", b"the first insider sui mascot that will reach a billion dollar market cap ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4272_dd578717b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOTYPUPPET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOOTYPUPPET>>(v1);
    }

    // decompiled from Move bytecode v6
}

