module 0x23fb4f2e86ddf304a1b7bb95d429b2dc9147ef4d417e0cd64efa47601a0f66eb::puf {
    struct PUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUF>(arg0, 6, b"PUF", b"Puffer Eat Carrot", x"5075666665722065617420636172726f742c207377696d6d696e67206f6e20245355492e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I_Is87_Jl_400x400_e30c086eed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

