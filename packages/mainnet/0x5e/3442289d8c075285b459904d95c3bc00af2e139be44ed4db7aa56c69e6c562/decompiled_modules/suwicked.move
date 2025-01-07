module 0x5e3442289d8c075285b459904d95c3bc00af2e139be44ed4db7aa56c69e6c562::suwicked {
    struct SUWICKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWICKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWICKED>(arg0, 6, b"SUWICKED", b"SUI WICKED", x"53776167205769636b6564200a0a68747470733a2f2f742e6d652f737761677769636b65640a68747470733a2f2f737761677769636b65642e66756e0a68747470733a2f2f782e636f6d2f737761677769636b6564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3489_670bb2bf15.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWICKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWICKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

