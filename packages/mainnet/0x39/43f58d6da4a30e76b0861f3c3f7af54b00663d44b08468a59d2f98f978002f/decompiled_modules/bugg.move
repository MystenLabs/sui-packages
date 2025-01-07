module 0x3943f58d6da4a30e76b0861f3c3f7af54b00663d44b08468a59d2f98f978002f::bugg {
    struct BUGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGG>(arg0, 6, b"BUGG", b"BUGGED BUNNY", b"Revolutionizing the crypto world with innovation and transparency!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_11_17_17_08_17_83628344e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

