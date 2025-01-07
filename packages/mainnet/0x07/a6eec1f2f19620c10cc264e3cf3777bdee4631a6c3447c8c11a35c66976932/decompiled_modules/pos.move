module 0x7a6eec1f2f19620c10cc264e3cf3777bdee4631a6c3447c8c11a35c66976932::pos {
    struct POS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POS>(arg0, 6, b"POS", b"Poseidon's Kiss", b"Poseidon's Kiss just launched on DEX! CA: 0xa9e10757ff984090dd608c3a19b15fec2d4ff0ec03c1a22aa123a0b2846ac6a2::pos::POS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/POS_Logo_b7b3d157db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POS>>(v1);
    }

    // decompiled from Move bytecode v6
}

