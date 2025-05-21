module 0xdd062c191cd2cc08985b2eaaecf0686557b6864af26bf1be479648b10c380e3b::kos {
    struct KOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOS>(arg0, 6, b"KOS", b"KUIonSUI", b"KUI is not just a crypto, not just a REVOLUTION!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidnlfvqg7u6vxlpgyqctjxdec3kduulhzhlhwaqi3jylnfm5uawue")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

