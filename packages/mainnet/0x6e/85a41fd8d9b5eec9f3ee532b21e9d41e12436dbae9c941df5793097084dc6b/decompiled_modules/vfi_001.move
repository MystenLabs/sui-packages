module 0x6e85a41fd8d9b5eec9f3ee532b21e9d41e12436dbae9c941df5793097084dc6b::vfi_001 {
    struct VFI_001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VFI_001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VFI_001>(arg0, 9, b"VFI_001", b"VFi", b"Vanilla Finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5699dcb-39cf-4aa1-8ccc-b451000199b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VFI_001>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VFI_001>>(v1);
    }

    // decompiled from Move bytecode v6
}

