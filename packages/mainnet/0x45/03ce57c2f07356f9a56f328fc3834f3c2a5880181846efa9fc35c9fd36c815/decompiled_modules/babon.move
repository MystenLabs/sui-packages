module 0x4503ce57c2f07356f9a56f328fc3834f3c2a5880181846efa9fc35c9fd36c815::babon {
    struct BABON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABON>(arg0, 6, b"BABON", b"Bara Bond", b"The market is full of mysteries, but none can hide from me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_073527_f97c585529.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABON>>(v1);
    }

    // decompiled from Move bytecode v6
}

