module 0x7324b14981e3b9077a0d1937110660848654b2eea78d2d4ed9540a7ed25e3d14::hamster {
    struct HAMSTER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HAMSTER>, arg1: 0x2::coin::Coin<HAMSTER>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HAMSTER>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HAMSTER>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: HAMSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSTER>(arg0, 6, b"HAMSTER SUI", b"HAMSTER", b"$HMSTR  is a Telegram Click to Earn Coin game developed on the #TON blockchain.  https://x.com/HMSTR_SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-shocked-dinosaur-182.mypinata.cloud/ipfs/QmPb5oNc7vupEoW23XRiZEJdLms7zD86qEuLrdZ4M4MkZC")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAMSTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<HAMSTER>, arg1: 0x2::coin::Coin<HAMSTER>) : u64 {
        0x2::coin::burn<HAMSTER>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<HAMSTER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HAMSTER> {
        0x2::coin::mint<HAMSTER>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

