module 0x264f6e827b2664fe1af236ac81d53178b3b08d12ae4f17a356d6a9d4d63d840b::ssussu {
    struct SSUSSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUSSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUSSU>(arg0, 6, b"SSUSSU", b"$SU$SU", b"SU SU COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8912_8e26d2279b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUSSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUSSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

