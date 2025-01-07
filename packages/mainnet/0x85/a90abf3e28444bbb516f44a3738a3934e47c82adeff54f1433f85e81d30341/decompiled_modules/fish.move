module 0x85a90abf3e28444bbb516f44a3738a3934e47c82adeff54f1433f85e81d30341::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"SUIFish", b"Let's swim together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fish_0c55357151.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

