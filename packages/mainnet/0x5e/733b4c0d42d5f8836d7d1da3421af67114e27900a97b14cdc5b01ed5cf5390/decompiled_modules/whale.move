module 0x5e733b4c0d42d5f8836d7d1da3421af67114e27900a97b14cdc5b01ed5cf5390::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"Whale", b"Willy the Whale", b"A colossal trader of the Sui sea. Tired of watching small fish get fried, he's breaching the surface to make a splash in the big pool. Join his pod and ride the wave to crypto glory", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_C_Kx_HDC_400x400_3a692cab6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

