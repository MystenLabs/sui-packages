module 0x72fb9ab02893b70b704b799566d070663534cfa6772db5fb1bc044d1b9013f04::sui1000x {
    struct SUI1000X has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI1000X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI1000X>(arg0, 6, b"SUI1000x", b"Sui to the moon", b"Sui to the moon. Sui 1000x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiddnjns2bx2efwmijcjderq6e7mdj4kfmvlbjfdx4euilhe4asrka")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI1000X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI1000X>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

