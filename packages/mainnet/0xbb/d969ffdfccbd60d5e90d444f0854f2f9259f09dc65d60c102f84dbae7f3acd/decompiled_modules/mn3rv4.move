module 0xbbd969ffdfccbd60d5e90d444f0854f2f9259f09dc65d60c102f84dbae7f3acd::mn3rv4 {
    struct MN3RV4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MN3RV4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MN3RV4>(arg0, 9, b"MN3RV4", b"Mn3rva", b"token for mn3rva", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ffa2b32-61e6-4db9-a799-d81ab0476c79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MN3RV4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MN3RV4>>(v1);
    }

    // decompiled from Move bytecode v6
}

