module 0xa5bec747f6439c6b72931d669ad60a1217426673d0b28a038747d209d046d048::squaaawk {
    struct SQUAAAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUAAAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUAAAWK>(arg0, 6, b"SQUAAAWK", b"aaaChick", b"The most annoying rubber chick is here on SUI Network, ready to quack all the way up! Squaaaawwwkkk!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001949_82aab928d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUAAAWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUAAAWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

