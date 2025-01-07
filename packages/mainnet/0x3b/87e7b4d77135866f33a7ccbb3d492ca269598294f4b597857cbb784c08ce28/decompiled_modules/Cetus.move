module 0x3b87e7b4d77135866f33a7ccbb3d492ca269598294f4b597857cbb784c08ce28::Cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CETUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CETUS>>(0x2::coin::mint<CETUS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 6, b"! Cetusairdrop com Cetus reward", b"CetusAirdrop.com", b"Token drop to active users of the CETUS platform! https://cetusairdrop.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/0mZ9rXj/cetus.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

