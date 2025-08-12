module 0x21e29985a72888092c057c9f6759afead07aac3f3fe5888a1ed9e6ac5185bf70::sats {
    struct SATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATS>(arg0, 6, b"SATS", b"Satoshi Terminal", b"Whoever was not born cannot have died", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihir4b62ds4joeoq5klvxzs7hkk4cp7o2vrgycweqjaoo5hmtqimi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SATS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

