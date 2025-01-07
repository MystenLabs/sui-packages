module 0x26e0ad1c06591c8290d2f3ca0055954e3fa27a417508e8ed7d31f670165c12a8::trumpoline {
    struct TRUMPOLINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPOLINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPOLINE>(arg0, 6, b"TRUMPOLINE", b"Trumpoline", b"Trum on a Trampoline", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_06_002851_652ea56cf7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPOLINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPOLINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

