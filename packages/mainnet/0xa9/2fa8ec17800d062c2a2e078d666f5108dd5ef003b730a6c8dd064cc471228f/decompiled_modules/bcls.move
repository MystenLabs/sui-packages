module 0xa92fa8ec17800d062c2a2e078d666f5108dd5ef003b730a6c8dd064cc471228f::bcls {
    struct BCLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCLS>(arg0, 9, b"BCLS", b"Bacillus", b"Bacillus (BCLS) is a unique cryptocurrency designed with a focus on decentralized finance (DeFi) ecosystems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/717d9f2d-d8de-48ad-9744-209594570910.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

