module 0xd6daff1726e72794a5ac6b990cb0e90602b4aef2390015a1d63070ca82a0bac0::suiminion {
    struct SUIMINION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMINION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMINION>(arg0, 6, b"SuiMinion", b"SUIMINION", b"SUI MEME OF HOPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1774548270720.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMINION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMINION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

