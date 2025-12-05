module 0x852e27a42d4809acc3da803bdf5f13995d4753e3b605a751ba4e7d6e6b4cc2f5::link {
    struct LINK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LINK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LINK> {
        0x2::coin::mint<LINK>(arg0, arg1, arg2)
    }

    fun init(arg0: LINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINK>(arg0, 9, b"LINK", b"ChainLink Token", b"The native token of the Chainlink Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d2f70xi62kby8n.cloudfront.net/tokens/link.webp?auto=compress%2Cformat")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<LINK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LINK>>(0x2::coin::mint<LINK>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

