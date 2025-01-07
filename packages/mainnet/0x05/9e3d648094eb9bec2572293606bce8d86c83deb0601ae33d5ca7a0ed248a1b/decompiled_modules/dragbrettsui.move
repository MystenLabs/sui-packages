module 0x59e3d648094eb9bec2572293606bce8d86c83deb0601ae33d5ca7a0ed248a1b::dragbrettsui {
    struct DRAGBRETTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGBRETTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGBRETTSUI>(arg0, 6, b"DRAGBRETTSUI", b"DRAGBRETT SUI", b"Once a great dragon soaring the sky now comes to SUI to dominate the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_23_17_48_68ff976083.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGBRETTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGBRETTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

