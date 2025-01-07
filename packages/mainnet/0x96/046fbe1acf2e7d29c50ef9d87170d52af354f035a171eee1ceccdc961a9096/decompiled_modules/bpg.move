module 0x96046fbe1acf2e7d29c50ef9d87170d52af354f035a171eee1ceccdc961a9096::bpg {
    struct BPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPG>(arg0, 9, b"BPG", b"BigPig", b"Hot Big Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a998d15-963f-427f-ae5c-9e48f306c6a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

