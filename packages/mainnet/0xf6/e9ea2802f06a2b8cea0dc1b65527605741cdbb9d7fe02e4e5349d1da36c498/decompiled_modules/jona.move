module 0xf6e9ea2802f06a2b8cea0dc1b65527605741cdbb9d7fe02e4e5349d1da36c498::jona {
    struct JONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JONA>(arg0, 6, b"Jona", b"Jona Mother", b"Just a mother's care", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mooooo_4c8d1ce32e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

