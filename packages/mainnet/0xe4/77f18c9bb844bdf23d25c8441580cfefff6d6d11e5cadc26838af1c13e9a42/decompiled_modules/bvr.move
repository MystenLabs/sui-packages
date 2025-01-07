module 0xe477f18c9bb844bdf23d25c8441580cfefff6d6d11e5cadc26838af1c13e9a42::bvr {
    struct BVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVR>(arg0, 6, b"BVR", b"BeaverMoon", b"A moonbag for the cold winter ahead...be wise like a beaver and heed the omen of the Beaver Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732489460740.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BVR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

