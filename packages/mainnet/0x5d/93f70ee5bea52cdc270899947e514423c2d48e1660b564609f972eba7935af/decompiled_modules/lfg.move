module 0x5d93f70ee5bea52cdc270899947e514423c2d48e1660b564609f972eba7935af::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 9, b"LFG", b"FLUXX", b"Flux Is For To Make You Rich, It's Not For Rich Because Rich Can't Afford Fluxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49657541-f18b-46ce-ae83-30f853fd53c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

