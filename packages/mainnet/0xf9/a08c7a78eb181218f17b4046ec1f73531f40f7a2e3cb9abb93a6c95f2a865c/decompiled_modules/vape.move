module 0xf9a08c7a78eb181218f17b4046ec1f73531f40f7a2e3cb9abb93a6c95f2a865c::vape {
    struct VAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAPE>(arg0, 6, b"VAPE", b"Vaporeon", b"Did you know...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/esrsefsefse_9424ea4079.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

