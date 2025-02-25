module 0xaca524681e5fab8fc1cf830e012f03d61c7d9a4b9c56648738a5ec41ea433a68::zed {
    struct ZED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZED>(arg0, 6, b"ZED", b"Zesdan", x"3344206dc3b4207068e1bb8f6e67206de1bb997420c491e1bb936e6720636f696e2076e1bb9b692074c3aa6e20225a657364616e222074726f6e672070686f6e672063c3a163682074c6b0c6a16e67206c61692c2076e1bb9b6920c3a16e682073c3a16e672078616e682076c3a0206ee1bb816e20637962657270756e6b2e204ee1babf752062e1baa16e206d75e1bb916e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/05193cb9-4fa4-4eed-8aaf-832b95bf73f7.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

