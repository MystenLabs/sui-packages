module 0xc71ee2be7595aa66cf19ae0040701a9c08442c252bb7467f2b80483ecc9267b9::hanhan {
    struct HANHAN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HANHAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HANHAN>>(0x2::coin::mint<HANHAN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HANHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANHAN>(arg0, 6, b"HANHAN", b"HANHAN", b"Hanhan Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/hanhanliuyue/USDP/refs/heads/main/hanhan.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

