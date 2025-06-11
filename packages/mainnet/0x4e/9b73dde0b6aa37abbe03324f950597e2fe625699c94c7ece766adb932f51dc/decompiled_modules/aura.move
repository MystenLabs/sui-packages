module 0x4e9b73dde0b6aa37abbe03324f950597e2fe625699c94c7ece766adb932f51dc::aura {
    struct AURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURA>(arg0, 6, b"AURA", b"Aura on Sui", x"497427732048617070656e200a0a2441555241206973206c697665206f6e205355490a0a4a75737420415552412e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiejiai6uxubqgiqgtcxps5edon2qbul2y3ddi42dyg3ackjcxxshq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AURA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

