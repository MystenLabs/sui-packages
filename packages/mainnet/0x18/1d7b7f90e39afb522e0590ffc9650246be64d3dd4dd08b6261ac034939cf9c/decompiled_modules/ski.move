module 0x181d7b7f90e39afb522e0590ffc9650246be64d3dd4dd08b6261ac034939cf9c::ski {
    struct SKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKI>(arg0, 6, b"SKI", b"Ski Mask Dog", b"SKI - The masked dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mi_OV_6c_Rj_400x400_fd4112b2f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

