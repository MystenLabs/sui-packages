module 0xdb404ad70d8d05e46757d960eb5a11ae5b64af42ef49e8baae41359604863185::s18 {
    struct S18 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S18, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S18>(arg0, 6, b"S18", b"Sui Glock 18", b"Sui Glock 18 is locked, loaded, and ready to fire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_59_8afa921fbc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S18>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S18>>(v1);
    }

    // decompiled from Move bytecode v6
}

