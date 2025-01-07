module 0xc1d35b471c725e2513ba031e1941ea092642917e61336945bfd83700685df19b::jls {
    struct JLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JLS>(arg0, 6, b"JLS", b"JellySUI", x"4a656c6c7966697368206973206c6f6f6b696e6720666f7220697473206d697373696f6e20696e207468652076617374206f6365616e0a4d20656d657320646f6e2774206e65656420616e797468696e672c206e6f20582c206e6f2054472c206e6f20576562", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_a751c84082.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

