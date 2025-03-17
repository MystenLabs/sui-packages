module 0xb25ca4c6ebb82d5634c5ed2d68a009798e06a182fdbeeb2f9ef1f8b9df5b7dd3::hf {
    struct HF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HF>(arg0, 9, b"HF", b"havingfu", b"nothing interesting just having fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9dd22dd4-6551-48a3-b14e-7db3b3ee6368.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HF>>(v1);
    }

    // decompiled from Move bytecode v6
}

