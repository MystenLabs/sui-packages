module 0x9cfacb390f46852b3e2599ba6e30fcd129b0f45ccbd76d9e84f0d2e2ec48d796::miku {
    struct MIKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKU>(arg0, 6, b"Miku", b"Hatsune", b"dev will do nothing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2234_5bc73d6388.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

