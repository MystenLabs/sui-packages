module 0x9dbe3ba314ab2860abf0fbabfecaa23e5e0e6b06e640469f434bc4644355cd54::wgun {
    struct WGUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WGUN>(arg0, 6, b"WGUN", b"WATER GUN", b"It's just a Water Gun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WATERGUN_8be58a112b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WGUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

