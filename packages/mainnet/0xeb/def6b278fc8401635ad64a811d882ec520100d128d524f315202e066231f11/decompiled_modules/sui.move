module 0xebdef6b278fc8401635ad64a811d882ec520100d128d524f315202e066231f11::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"Sui", b"SuiNetwork", b"Layer 1 blockchain designed to make digital asset ownership fast, private, secure, and accessible to everyone. Twitter by@ SuiFoundation. RT endorsement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifg6bduabdmnq533txksnclsgytqh6qqoc43chpgoffun2h7p5vii")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

