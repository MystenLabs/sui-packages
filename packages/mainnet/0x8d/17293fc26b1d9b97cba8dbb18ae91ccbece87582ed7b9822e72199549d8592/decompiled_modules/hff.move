module 0x8d17293fc26b1d9b97cba8dbb18ae91ccbece87582ed7b9822e72199549d8592::hff {
    struct HFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFF>(arg0, 6, b"HFF", b"Holy Frog Father", x"5468652073746f7279206f662054686520486f6c792046726f67200a0a4973206120747269756d7068616e74206f6e6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/is_Yveu1q_400x400_2561d8d57e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

