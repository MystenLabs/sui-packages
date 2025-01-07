module 0x548d8d0efb0d38e4f80af73e3ec189d7a50beeea7e4de683b53f233c0a714c95::crr {
    struct CRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRR>(arg0, 9, b"CRR", b"car", b"quick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/911fae46-981f-4dc9-a7b5-ad0d7d76f3e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

