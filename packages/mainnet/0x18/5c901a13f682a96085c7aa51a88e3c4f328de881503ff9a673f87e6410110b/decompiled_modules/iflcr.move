module 0x185c901a13f682a96085c7aa51a88e3c4f328de881503ff9a673f87e6410110b::iflcr {
    struct IFLCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: IFLCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IFLCR>(arg0, 9, b"IFLCR", b"Influencer", b"For world crypto influencers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0ac901d-433e-4c50-a7cb-005f9b7846f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IFLCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IFLCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

