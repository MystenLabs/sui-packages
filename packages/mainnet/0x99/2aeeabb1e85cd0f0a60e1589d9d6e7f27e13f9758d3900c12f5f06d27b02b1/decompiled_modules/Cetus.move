module 0x992aeeabb1e85cd0f0a60e1589d9d6e7f27e13f9758d3900c12f5f06d27b02b1::Cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CETUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CETUS>>(0x2::coin::mint<CETUS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 6, b"! Cetusairdrop com Cetus reward", b"CetusAirdrop.com", b"Token drop to active users of the CETUS platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/grMWK5X/photo-2024-10-25-20-04-32.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

