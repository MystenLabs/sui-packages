module 0xbef9ace847af92f25527bb3b155c45c2d0aad95b0ef736664eb469b33c74f417::pipod {
    struct PIPOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPOD>(arg0, 6, b"PIPOD", b"Pipodromo", b"The kite revolution is reaching a new level, a digital currency that unites kite flyers and suppliers, bringing confidence and freedom to lovers of this sport in the world of cryptocurrencies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726804405805_f3ca8e26e4bc6104df131bc28a7e786a_260bdfdb56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

