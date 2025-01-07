module 0x733e8aad10b3507f462c3104473c19cd5dc7c7df6e2333fda2c11320c844ed3c::vortex {
    struct VORTEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VORTEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VORTEX>(arg0, 6, b"VORTEX", b"VORTEX SUI", b"VORTEX, the first chaos agent with a heart of gold and a mind full of ripples.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_12_d0803debbe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VORTEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VORTEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

