module 0x800a7f1f07db1e78da2bf5e5a58fe6fb724d0bc6bfac2a8b37004c7cbb830291::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 6, b"S", b"$S Agent S", x"4167656e74205320697320746865207072656d696572206175746f6e6f6d6f7573204149206f6e207468652023535549206e6574776f726b0a6f66666572696e672063757474696e672d656467652041492d706f776572656420746f6f6c73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058245_1077de1426.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}

