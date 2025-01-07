module 0xa96b06a34560f9526a83b0839b0167d9decfe21c0434a91e77d7f7d956109a85::roger {
    struct ROGER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROGER>, arg1: 0x2::coin::Coin<ROGER>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROGER>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ROGER>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: ROGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROGER>(arg0, 6, b"ROGER", b"Roger Sui", b"$ROGER, the flamboyant alien from American Dad!   https://roger.baby/   https://x.com/RogerBabySui   https://t.me/RogerBabySui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmePekN6Y2jJknQNBZkJjj3pGmR2vbtBB5hkerpJCpm1Jj")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROGER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROGER>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<ROGER>, arg1: 0x2::coin::Coin<ROGER>) : u64 {
        0x2::coin::burn<ROGER>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<ROGER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ROGER> {
        0x2::coin::mint<ROGER>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

