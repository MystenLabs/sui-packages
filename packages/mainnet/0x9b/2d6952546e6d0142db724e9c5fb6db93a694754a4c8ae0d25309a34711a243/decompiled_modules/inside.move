module 0x9b2d6952546e6d0142db724e9c5fb6db93a694754a4c8ae0d25309a34711a243::inside {
    struct INSIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSIDE>(arg0, 6, b"INSIDE", b"INSIDEINSUI", x"494e5349444520494e2043525950544f204f4e20545552424f530a5457495454455220495320434f4d494e4720534f4f4e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730970711816.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INSIDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSIDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

