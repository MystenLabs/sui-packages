module 0x3c4629bfb6a0090c71128b7ea9188b74fdeb1b4b206ef46d6f5faf728d2d3bf9::penis {
    struct PENIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENIS>(arg0, 6, b"PENIS", b"Inverse Penis", b"just an Inverse Penis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_4dee8454f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

