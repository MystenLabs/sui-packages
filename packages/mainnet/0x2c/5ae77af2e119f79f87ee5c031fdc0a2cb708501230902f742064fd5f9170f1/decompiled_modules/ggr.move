module 0x2c5ae77af2e119f79f87ee5c031fdc0a2cb708501230902f742064fd5f9170f1::ggr {
    struct GGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGR>(arg0, 9, b"GGR", b"girl", b"Join us for shopping", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/647e2388-13ad-4a99-a2c2-548c21de0574.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

