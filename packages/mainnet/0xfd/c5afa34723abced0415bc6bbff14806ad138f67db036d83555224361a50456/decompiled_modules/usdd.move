module 0xfdc5afa34723abced0415bc6bbff14806ad138f67db036d83555224361a50456::usdd {
    struct USDD has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDD>>(0x2::coin::mint<USDD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDD>(arg0, 6, b"USDD", b"USDD", b"Sui token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/hanhanliuyue/USDP/refs/heads/main/images.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

