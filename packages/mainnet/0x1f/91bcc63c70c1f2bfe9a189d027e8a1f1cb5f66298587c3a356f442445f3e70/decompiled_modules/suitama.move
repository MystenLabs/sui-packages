module 0x1f91bcc63c70c1f2bfe9a189d027e8a1f1cb5f66298587c3a356f442445f3e70::suitama {
    struct SUITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAMA>(arg0, 6, b"SUITAMA", b"Suitama", x"2453554954414d4120697320746865206d61696e2070726f7461676f6e697374206f66207468652073657269657320616e642074686520746974756c6172204f6e652d50756e6368204d616e206f6e2053756920436861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_a9cb7ee81d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

