module 0x4a24720276df64f5ae8b433ded413c5389f5bda96e5e2369829e00f714a4fc16::gb {
    struct GB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GB>(arg0, 9, b"GB", b"GummyBear", b"Just gummy, but the bear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8408a67b-7700-429f-be71-eb48ef2a0c56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GB>>(v1);
    }

    // decompiled from Move bytecode v6
}

