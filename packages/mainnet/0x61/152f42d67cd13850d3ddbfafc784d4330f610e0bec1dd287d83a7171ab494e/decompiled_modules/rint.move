module 0x61152f42d67cd13850d3ddbfafc784d4330f610e0bec1dd287d83a7171ab494e::rint {
    struct RINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RINT>(arg0, 6, b"Rint", b"Rin Tin Tin", b"The most famous dog ever ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3739_f385e498a6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

