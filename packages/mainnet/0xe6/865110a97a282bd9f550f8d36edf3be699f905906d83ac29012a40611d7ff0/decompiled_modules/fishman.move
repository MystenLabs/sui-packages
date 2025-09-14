module 0xe6865110a97a282bd9f550f8d36edf3be699f905906d83ac29012a40611d7ff0::fishman {
    struct FISHMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHMAN>(arg0, 9, b"Fishman", b"Fishman", b"Fishman riding the waves of the Sui blockchain, bringing joy and adventure to all who encounter it. | Website: https://x.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/PAYN2Xt.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

