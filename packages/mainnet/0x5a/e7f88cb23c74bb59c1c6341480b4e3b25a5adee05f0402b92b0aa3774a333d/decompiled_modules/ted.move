module 0x5ae7f88cb23c74bb59c1c6341480b4e3b25a5adee05f0402b92b0aa3774a333d::ted {
    struct TED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TED>(arg0, 6, b"TED", b"Ted The Turtle", x"2454454420697320746865206d6f7374206375746520616e64206661737420747572746c6520696e207468652077686f6c65206d656d65636f696e2073797374656d2e20526561647920746f206c6966742075703f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_88c7713307.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TED>>(v1);
    }

    // decompiled from Move bytecode v6
}

