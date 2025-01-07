module 0xd01aeac17da0fdbce641a9bbbcb97043b829544c40f29438782a0c43247972c6::kik {
    struct KIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIK>(arg0, 9, b"KIK", b"Kick", b"Memekick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e245c0a1-6d18-4ed4-8b67-d9910e4b4c18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

