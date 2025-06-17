module 0xc8858eb8d1b172a6f4f6aae81f1ba5a3273eb9b6be7754c362b14cc076c5850f::ricomask {
    struct RICOMASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICOMASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICOMASK>(arg0, 6, b"RICOMASK", b"Rico Mask", b"Hide your face, Show your bag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibsaym43ebrclm57cs3cym4urezzkqvvvroxnlfr2yvna3a3bmrwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICOMASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RICOMASK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

