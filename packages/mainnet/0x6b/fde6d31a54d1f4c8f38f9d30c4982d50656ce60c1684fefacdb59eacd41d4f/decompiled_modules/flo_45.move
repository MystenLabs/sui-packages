module 0x6bfde6d31a54d1f4c8f38f9d30c4982d50656ce60c1684fefacdb59eacd41d4f::flo_45 {
    struct FLO_45 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLO_45, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLO_45>(arg0, 9, b"FLO_45", b"Flogxy", b"Flogxycoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b3cb04b-0db6-4550-a73e-1a0f7515bcdf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLO_45>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLO_45>>(v1);
    }

    // decompiled from Move bytecode v6
}

