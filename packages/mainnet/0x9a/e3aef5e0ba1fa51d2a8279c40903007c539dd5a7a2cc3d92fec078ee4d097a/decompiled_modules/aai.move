module 0x9ae3aef5e0ba1fa51d2a8279c40903007c539dd5a7a2cc3d92fec078ee4d097a::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAI", b"Agent AI", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737183448151.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

