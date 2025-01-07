module 0xfacf350f4a5099cf8b54b055f419ddf24190f42457eadb96a5e1b0aa0e00fa72::pochita {
    struct POCHITA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<POCHITA>, arg1: 0x2::coin::Coin<POCHITA>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POCHITA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POCHITA>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: POCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITA>(arg0, 6, b"Pochita Sui CTO", b"POCHITA", b"Pochita The New Cheems   https://x.com/pochitasuicto https://t.me/pochitasuichat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmUXvbnEc82DmU7i4MXqL3g8WgRRgomiSN3JkrFNofHs4A")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POCHITA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITA>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<POCHITA>, arg1: 0x2::coin::Coin<POCHITA>) : u64 {
        0x2::coin::burn<POCHITA>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<POCHITA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<POCHITA> {
        0x2::coin::mint<POCHITA>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

