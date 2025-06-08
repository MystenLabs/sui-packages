module 0x6dcf0b079227ed8ca20865c905b24c7f5d9a73dabfd4ea3e95bc7848650f0828::eelon {
    struct EELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: EELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EELON>(arg0, 6, b"EELON", b"EELON SUI", b"The most electric memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib2xmbhxii5u7w4brwkjev47mbigfijmhdgqwnhqgchydsn3soxay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EELON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

