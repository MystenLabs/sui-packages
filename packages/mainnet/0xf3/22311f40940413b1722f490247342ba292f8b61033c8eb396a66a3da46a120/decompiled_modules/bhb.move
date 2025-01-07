module 0xf322311f40940413b1722f490247342ba292f8b61033c8eb396a66a3da46a120::bhb {
    struct BHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHB>(arg0, 9, b"BHB", b"MIUW", b"KAKBIPISHI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3979f608-8701-4e8e-a45c-566761f02e67.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BHB>>(v1);
    }

    // decompiled from Move bytecode v6
}

