module 0x3df49ba6bb411f2c4b4adef04b7de2c5855f704e7cd27c19165a377b6f8869d::dorklord {
    struct DORKLORD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DORKLORD>, arg1: 0x2::coin::Coin<DORKLORD>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DORKLORD>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DORKLORD>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: DORKLORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORKLORD>(arg0, 6, b"DORKL", b"DorkLord", b"The Dork Lord of SUI   https://dorklordonsui.com/   https://x.com/dorklordofsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmTArRPTzPW4hXLVGMxXTpLo2wE4w33am7XPfkAmxCwvtb")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DORKLORD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORKLORD>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DORKLORD>, arg1: 0x2::coin::Coin<DORKLORD>) : u64 {
        0x2::coin::burn<DORKLORD>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<DORKLORD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DORKLORD> {
        0x2::coin::mint<DORKLORD>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

