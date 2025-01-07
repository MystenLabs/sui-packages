module 0x7214f654ad67601ae98bf05fac20639e59417e6817784d1ba5838d786e0ef163::nip {
    struct NIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIP>(arg0, 6, b"NIP", b"Catnip", b"Just a cat and his catnip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6901_ccdea13ffa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

