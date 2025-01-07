module 0x85e602744a9732c91b55a83eb20669f4358bca48d0ee1485635ebde574519c2d::freecz {
    struct FREECZ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FREECZ>, arg1: 0x2::coin::Coin<FREECZ>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FREECZ>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FREECZ>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: FREECZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREECZ>(arg0, 6, b"FREE CZ", b"CZ", b"In a world where crypto innovation is constantly under threat of malicious regulations engineered by SEC, FREE CZ token emerges as the symbol of FREEDOM.? https://x.com/czoutmeme https://t.me/freeczportal  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmRNW1i3cChCckBxBzYwSFnk5obp3bVNcStyLKrRJCc92d")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREECZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREECZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<FREECZ>, arg1: 0x2::coin::Coin<FREECZ>) : u64 {
        0x2::coin::burn<FREECZ>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<FREECZ>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FREECZ> {
        0x2::coin::mint<FREECZ>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

