module 0xed2c44c7b9b0d2bda9fc6c212bc21c5447ff68a0f6a04f5e176de0a2daa27710::orb {
    struct ORB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORB>(arg0, 9, b"ORB", b"THRGO", b"Illuminate the crypto space with the ORB Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7cc086bb-205a-4f64-813f-6f65a2a96d4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORB>>(v1);
    }

    // decompiled from Move bytecode v6
}

