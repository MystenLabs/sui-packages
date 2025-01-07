module 0xcfffdc5ff4a3c97c1519a0c83d426ceaed7c9ba8493315b268a4fe7543234cd1::sharkety {
    struct SHARKETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKETY>(arg0, 6, b"Sharkety", b"Sharkety On Sui", x"48656c6c6f205375692061726d7921212077687265206973206d792074656574680a536861726b65747920746865206669727374206d656d65636f696e206f6e207375692077696c6c20686974203142206361702121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_move_pump_1f47fc5973.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKETY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKETY>>(v1);
    }

    // decompiled from Move bytecode v6
}

