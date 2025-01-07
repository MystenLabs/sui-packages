module 0xa11c700efb28ea2f394cb097c7ee2bc52b72cae39a9e62b2b9fa9044a85e78ef::skynet {
    struct SKYNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYNET>(arg0, 6, b"SKYNET", b"SKYNET SUI", b"SKYNET is here to take over the Solana and the whole world next!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_02_33_39_46c5bdca65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKYNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

