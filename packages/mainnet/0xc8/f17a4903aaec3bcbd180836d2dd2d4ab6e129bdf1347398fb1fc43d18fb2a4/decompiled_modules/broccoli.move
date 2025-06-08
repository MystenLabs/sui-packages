module 0xc8f17a4903aaec3bcbd180836d2dd2d4ab6e129bdf1347398fb1fc43d18fb2a4::broccoli {
    struct BROCCOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCCOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCCOLI>(arg0, 6, b"Broccoli", b"First Broccoli", x"546865206f726967696e616c2042726f63636f6c692e0a0a46756c6c7920636f6d6d756e6974792d6f776e656420616e64206d616e6167656420746f6b656e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_N_N_N_885550dc9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCCOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROCCOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

