module 0x8662adfa8abf8d16ae6a1ab30c692f120b64a79b9faf68f8af78181c7b4956c3::sul {
    struct SUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUL>(arg0, 6, b"SUL", b"Suilana", b"Solana on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0265_911c1e1658.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

