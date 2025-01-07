module 0x90d653c4d550c5900739b562e79f6bbf5f1b9fd64d8e4461fb359b73dc7532a::mosasaurus {
    struct MOSASAURUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSASAURUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSASAURUS>(arg0, 9, b"MOSASAURUS", b"SeaMonster", b"Sea monster that ready to rule the SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec811b17-bad1-4ece-b6df-71fa32d8b07b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSASAURUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOSASAURUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

