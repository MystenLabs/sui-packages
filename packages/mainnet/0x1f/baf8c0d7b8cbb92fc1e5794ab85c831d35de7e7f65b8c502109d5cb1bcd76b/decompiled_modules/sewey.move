module 0x1fbaf8c0d7b8cbb92fc1e5794ab85c831d35de7e7f65b8c502109d5cb1bcd76b::sewey {
    struct SEWEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEWEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEWEY>(arg0, 6, b"Sewey", b"Sewey fast blockchain", b"a great blockchain that is fast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9802_2a0371108f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEWEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEWEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

