module 0x8821f6449d7586904513ac54a996d3d0d290bfafc20608b5b90d0df796563648::doom {
    struct DOOM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOOM>, arg1: 0x2::coin::Coin<DOOM>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOOM>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOOM>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: DOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOM>(arg0, 6, b"$DOOM", b"DOOM", b"Doom PlayToEarn is a thrilling play-to-earn (P2E) crypto   https://www.dooom.pro/   https://x.com/doomsui   https://t.me/doomsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmfJ5BJzVTRnRb9p2sLQRfaCXBSarA8D86UBiQnnwRtHQy")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DOOM>, arg1: 0x2::coin::Coin<DOOM>) : u64 {
        0x2::coin::burn<DOOM>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<DOOM>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DOOM> {
        0x2::coin::mint<DOOM>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

