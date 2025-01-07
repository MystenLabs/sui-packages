module 0x1b40e83903d29b63fe0502c7371708f2abfe3f37e2ed0cc2b845562155c44546::gigadog {
    struct GIGADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGADOG>(arg0, 9, b"GIGADOG", b"GigaDog", b"\"GigaDog\" is the ultimate memecoin on the Sui blockchain, blending humor with DeFi innovation. Fast, fun, and community-driven, GigaDog is here to fetch gains and unleash the future of crypto. Join the pack and ride the GigaWave to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3adbe2ea-1d47-465f-8b53-3e73f4182405.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIGADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

