module 0xc56afb46cfaf7781e92abcce5b9de229cb5e862fd134dc493fba8749951e0f8e::aiart {
    struct AIART has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIART>(arg0, 6, b"AiART", b"Ai", b"Artificial Intelligence Arts AI powered traditional art pieces", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736450080850.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIART>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

