module 0x4b2e29cb7678637cbfc2f124ff29c98d3b286b5ed270680ccfae84c5efe918eb::hlb {
    struct HLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLB>(arg0, 9, b"HLB", b"HightlandB", b"A coin inspired by a cup of highland coffee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98a4d9f0-8e93-45f8-b5f9-51ccbac0927e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

