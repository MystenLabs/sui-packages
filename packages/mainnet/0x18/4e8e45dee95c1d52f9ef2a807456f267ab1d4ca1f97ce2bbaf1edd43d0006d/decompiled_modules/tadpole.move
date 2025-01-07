module 0x184e8e45dee95c1d52f9ef2a807456f267ab1d4ca1f97ce2bbaf1edd43d0006d::tadpole {
    struct TADPOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TADPOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TADPOLE>(arg0, 6, b"TADPOLE", b"Tadpole on Sui", b"Now living on the Sui network, Tadpole has quickly become the iconic mascot of the Sui ecosystem. tadpoleonsui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_114400_545a9a547e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TADPOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TADPOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

