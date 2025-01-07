module 0x4fff613fa0efb98d44ec019bdaae2ea645f133e9f22c1cd6357a22a9758cc96a::cets {
    struct CETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETS>(arg0, 6, b"Cets", b"Sui Cets", b"it's a cets coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/headscat_8a0437d845.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

