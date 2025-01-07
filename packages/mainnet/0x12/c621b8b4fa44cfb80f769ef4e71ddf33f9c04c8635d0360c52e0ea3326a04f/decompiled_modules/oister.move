module 0x12c621b8b4fa44cfb80f769ef4e71ddf33f9c04c8635d0360c52e0ea3326a04f::oister {
    struct OISTER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OISTER>, arg1: 0x2::coin::Coin<OISTER>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OISTER>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OISTER>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: OISTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OISTER>(arg0, 6, b"OISTER", b"OISTER", b"$OISTER innovative ecosystem offers a 3D NFT Metaverse,DeFi utilities a crypto education platform, NFTs,a merchandise store,and more.  https://www.oister.tech/  https://x.com/oistersui  https://t.me/oistersui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmYMxtfu83adFEAjoxh31m4fLvJRBamGRx7TLQg5xJVYD4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OISTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OISTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<OISTER>, arg1: 0x2::coin::Coin<OISTER>) : u64 {
        0x2::coin::burn<OISTER>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<OISTER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<OISTER> {
        0x2::coin::mint<OISTER>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

