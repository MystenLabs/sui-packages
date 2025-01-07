module 0x83b045cd0361458c9ff372774f5a9d6ba2566108ed54fbdc5310292428bf7c7::bpg {
    struct BPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPG>(arg0, 9, b"BPG", b"BigPig", b"Hot Big Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ac355e8-bafa-420f-8548-c65dfa328c11.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

