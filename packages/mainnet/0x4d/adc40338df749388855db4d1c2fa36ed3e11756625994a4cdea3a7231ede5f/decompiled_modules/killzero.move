module 0x4dadc40338df749388855db4d1c2fa36ed3e11756625994a4cdea3a7231ede5f::killzero {
    struct KILLZERO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KILLZERO>, arg1: 0x2::coin::Coin<KILLZERO>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KILLZERO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KILLZERO>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: KILLZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLZERO>(arg0, 6, b"KILL ZERO", b"KILL", b"$KILL on $SUI Let's kill the bottom! https://www.killzero.org/  https://x.com/killzerosui https://t.me/killzero_portal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-magnetic-ptarmigan-262.mypinata.cloud/ipfs/QmYigiKeNknK9gc4JPNcjU3qKLPqMBwaToYPUPBBjYgmA5")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KILLZERO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLZERO>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<KILLZERO>, arg1: 0x2::coin::Coin<KILLZERO>) : u64 {
        0x2::coin::burn<KILLZERO>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<KILLZERO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KILLZERO> {
        0x2::coin::mint<KILLZERO>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

