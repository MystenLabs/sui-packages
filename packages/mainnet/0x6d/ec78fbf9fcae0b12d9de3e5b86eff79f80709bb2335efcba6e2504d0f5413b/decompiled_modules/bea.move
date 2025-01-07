module 0x6dec78fbf9fcae0b12d9de3e5b86eff79f80709bb2335efcba6e2504d0f5413b::bea {
    struct BEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEA>(arg0, 9, b"BEA", b"BEAR ", b"BEAR CUTE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/41a762a5-434d-4e2a-bf0d-653fe4897f5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

