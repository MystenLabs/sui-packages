module 0x95594c627fc7fb54a5eccbfc13f8ccc98458436558d9e9624afe2fb38f060f05::sharkwif {
    struct SHARKWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKWIF>(arg0, 6, b"SHARKWIF", b"Shark Wif Hat", x"496e74726f647563696e672024534841524b57494620546865206f6e6c7920636f696e20746861742061637475616c6c79207465616368657320796f7520736f6d657468696e672e205768696c6520746865207265737420636861736520687970652c207468697320736861726b207374617973207468726565206d6f7665732061686561642c20636f766572696e6720686973206d61737369766520627261696e207769746820612068617420736f20746865207765616b20646f6e742067657420696e74696d6964617465642e204f6e6c792074686520736861727065737420646567656e732077696c6c206b6565702075702e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sharkwiflogo_cc82944e7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

