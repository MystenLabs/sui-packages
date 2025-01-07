module 0xb2c8f492c2af4309f201c25828e984d0812b90cafd1c0f317c4a8fc3287b494b::wk {
    struct WK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WK>(arg0, 6, b"WK", b"GREG", b"Wimpy Kid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_15_03_53_05_61647e720b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WK>>(v1);
    }

    // decompiled from Move bytecode v6
}

