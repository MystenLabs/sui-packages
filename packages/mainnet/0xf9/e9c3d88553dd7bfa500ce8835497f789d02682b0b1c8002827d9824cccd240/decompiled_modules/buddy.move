module 0xf9e9c3d88553dd7bfa500ce8835497f789d02682b0b1c8002827d9824cccd240::buddy {
    struct BUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDDY>(arg0, 6, b"BUDDY", b"First Buddy On Sui", b"First Buddy On Sui.Join now: https://www.buddyonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_1_261d2a69f9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

