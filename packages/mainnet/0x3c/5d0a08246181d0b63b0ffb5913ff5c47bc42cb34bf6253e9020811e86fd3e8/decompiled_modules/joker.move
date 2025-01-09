module 0x3c5d0a08246181d0b63b0ffb5913ff5c47bc42cb34bf6253e9020811e86fd3e8::joker {
    struct JOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER>(arg0, 6, b"Joker", b"Joker ai agent ", b"Meet your emoji-powered joke-telling assistant! Always ready to bring a smile with witty jokes and creative emoji combinations", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736446116114.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

