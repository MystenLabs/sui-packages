module 0xc058f57f25b4b404f02e5f151eec77f9e4f3c1a7929b9e21be07d8c423450bc5::delayed {
    struct DELAYED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELAYED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELAYED>(arg0, 6, b"DELAYED", b"HOP FUN DELAYED", b"HOP FUN IS DELAYED! NEW LAUNCH 10/20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/delayed_3f23e78a3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELAYED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELAYED>>(v1);
    }

    // decompiled from Move bytecode v6
}

