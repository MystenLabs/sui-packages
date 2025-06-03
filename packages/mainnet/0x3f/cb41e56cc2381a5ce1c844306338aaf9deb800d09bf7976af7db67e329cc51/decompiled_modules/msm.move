module 0x3fcb41e56cc2381a5ce1c844306338aaf9deb800d09bf7976af7db67e329cc51::msm {
    struct MSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSM>(arg0, 6, b"MSM", b"Morning sui moon", b"M gm sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibosxzp4wy7nfqdhav5zzg7o5uyobgf2b3rhjft5i32drlk563rxa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MSM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

